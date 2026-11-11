#!/bin/bash
# awscc-oauth2-watch — pings when the published hashicorp/terraform-provider-awscc
# release exposes `client_authentication_method` on the BedrockAgentCore OAuth2
# credential provider resource (unblocks declarative secretless AWS_IAM_ID_TOKEN_JWT
# auth in Terraform). Run daily by a launchd agent; self-quiets once it fires.
#
# Manual run:   ~/.scripts/awscc-oauth2-watch.sh
# Logs:         ~/.local/state/awscc-oauth2-watch/watch.log
# Disable:      launchctl bootout gui/$(id -u)/com.alexanderjeurissen.awscc-oauth2-watch
set -euo pipefail

# launchd hands us a minimal PATH — make sure brew + system bins resolve.
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

REPO="hashicorp/terraform-provider-awscc"
RESOURCE="internal/aws/bedrockagentcore/o_auth_2_credential_provider_resource_gen.go"
FIELD="client_authentication_method"
STATE_DIR="$HOME/.local/state/awscc-oauth2-watch"
MARKER="$STATE_DIR/found"
LOG="$STATE_DIR/watch.log"
LABEL="com.alexanderjeurissen.awscc-oauth2-watch"

mkdir -p "$STATE_DIR"
log() { echo "$(date '+%Y-%m-%d %H:%M:%S') $*" >>"$LOG"; }

# Already fired — nothing to do.
if [[ -f "$MARKER" ]]; then
  log "already notified ($(cat "$MARKER")); skipping"
  exit 0
fi

latest=$(gh release list --repo "$REPO" --limit 1 | awk 'NR==1{print $1}')
if [[ -z "$latest" ]]; then
  log "ERROR: could not resolve latest release (gh auth/network?)"
  exit 0
fi

count=$(gh api "repos/$REPO/contents/$RESOURCE?ref=$latest" --jq '.content' \
          | base64 -d | grep -c "$FIELD" || true)

if [[ "${count:-0}" -ge 1 ]]; then
  log "FOUND in $latest (count=$count) — notifying"
  echo "$latest" >"$MARKER"
  MSG="awscc $latest exposes ${FIELD} — secretless AWS_IAM_ID_TOKEN_JWT is now provisionable in Terraform."
  terminal-notifier -title "awscc watch ✅" -subtitle "$latest shipped the field" \
    -message "$MSG" -sound Glass 2>/dev/null || true
  osascript -e "display notification \"$MSG\" with title \"awscc watch ✅\" sound name \"Glass\"" 2>/dev/null || true
  # Self-disable so it stops running once the goal is met.
  launchctl bootout "gui/$(id -u)/$LABEL" 2>/dev/null || true
else
  log "not in $latest (count=0)"
fi
