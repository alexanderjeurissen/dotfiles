# This checks if the current branch is ahead of
# or behind the remote branch with which it is tracked

__parse_git_stats(){
  type git >/dev/null 2>&1
  if [ "$?" -ne 0 ]; then
    return
  fi

  # Check if git.
  [[ -z $(git rev-parse --git-dir 2> /dev/null) ]] && return

  # Return the status
  staged=`echo $(git diff --staged --name-status | wc -l) | tr -d ' '`
  modified=`echo $(git ls-files --modified | wc -l) | tr -d ' '`
  others=`echo $(git ls-files --others --exclude-standard | wc -l) | tr -d ' '`
  # tracking_branch=$(git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD))
  # behind, ahead = $(git rev-list --left-right --count $tracking_branch...HEAD)
  echo "$staged,$modified,$others"
}


buffer_path=$1
if [ -d $buffer_path ]; then
  cd $buffer_path

  if [ -n "${git_stats=$(__parse_git_stats)}" ]; then
    stats="$git_stats"
  fi

  printf %s "${stats}"
fi
