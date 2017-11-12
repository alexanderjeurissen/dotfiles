# export NODENV_ROOT=/usr/local/var/nodenv

if which rbenv > /dev/null; then eval "$(rbenv init - --no-rehash)"; fi
if which nodenv > /dev/null; then eval "$(nodenv init - --no-rehash)"; fi
. $(brew --prefix nodenv)/completions/nodenv.zsh

# export NVM_DIR=~/.nvm
# . $(brew --prefix nvm)/nvm.sh
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"


# makes sure global bin is respected when doing yarn global add
# https://github.com/yarnpkg/yarn/issues/1027
export PATH="$PATH:$(yarn global bin)"
