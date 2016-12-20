  export NODENV_ROOT=/usr/local/var/nodenv

  if which rbenv > /dev/null; then eval "$(rbenv init - --no-rehash)"; fi
  if which nodenv > /dev/null; then eval "$(nodenv init - --no-rehash)"; fi

  # export NVM_DIR=~/.nvm
  # . $(brew --prefix nvm)/nvm.sh
