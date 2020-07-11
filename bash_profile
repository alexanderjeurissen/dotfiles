export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH="/Users/alexanderjeurissen/Development/arcanist/bin:$PATH"
eval "$(rbenv init -)"

if which nodenv > /dev/null; then eval "$(nodenv init - --no-rehash)"; fi
# export NVM_DIR=~/.nvm
# source $(brew --prefix nvm)/nvm.sh
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
export PATH="/Users/alexander/Development/arcanist/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"
