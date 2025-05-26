# Set path {{{
export PATH="" # Reset path so homebrew has precedence
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/opt:$PATH"
export PATH="$HOMEBREW_PREFIX/bin:$PATH"
export PATH="$HOMEBREW_PREFIX/sbin:$PATH"
export PATH="$HOME/.scripts:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
# }}}

# Go path settings {[{
export GOPATH="$HOME/Development/go"
export PATH="$GOPATH/bin:$PATH"
# }}}

# Ruby settings {{{
export ENABLE_SPRING=0
export LDFLAGS="-L$HOMEBREW_PREFIX/opt/ruby@3.3/lib"
export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/ruby@3.3/include"
export PATH="$HOMEBREW_PREFIX/opt/ruby@3.3/bin:$PATH"
export PATH="$HOME/.gem/ruby/3.3.0/bin:$PATH"
export PATH="$HOMEBREW_PREFIX/lib/ruby/gems/3.3.0/bin:$PATH"
# }}}

# Lua settings (derived from $ luarocks path)
export LUA_PATH='/opt/homebrew/Cellar/luarocks/3.11.1/share/lua/5.4/?.lua;/opt/homebrew/Cellar/luarocks/3.9.1/share/lua/5.4/?.lua;/opt/homebrew/share/lua/5.4/?.lua;/opt/homebrew/share/lua/5.4/?/init.lua;/opt/homebrew/lib/lua/5.4/?.lua;/opt/homebrew/lib/lua/5.4/?/init.lua;./?.lua;./?/init.lua;/Users/alexander/.luarocks/share/lua/5.4/?.lua;/Users/alexander/.luarocks/share/lua/5.4/?/init.lua'
export LUA_CPATH='/opt/homebrew/lib/lua/5.4/?.so;/opt/homebrew/lib/lua/5.4/loadall.so;./?.so;/Users/alexander/.luarocks/lib/lua/5.4/?.so'

# Add default binaries /usr/bin etc at lowest prio {{{
export PATH="$PATH:/usr/bin"
export PATH="$PATH:/bin"
export PATH="$PATH:/usr/sbin"
export PATH="$PATH:/sbin"
# }}}

typeset -U path PATH


# Java settings
# export JAVA_HOME="/usr/libexec/java_home"
# export MAVENPATH="$HOME/.maven"
# export PATH="$MAVENPATH/bin:$PATH"

export FZF_DEFAULT_OPTS='--color=bw,border:0,info:2,prompt:12,fg:,bg+:0,fg+:,gutter:0 --height 40% --reverse --prompt="  " --border=none --no-separator --no-scrollbar'
export _ZO_FZF_OPTS="--height 40% --reverse $FZF_DEFAULT_OPTS"
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND='rg --files'

# LS colors settings {{{
  # retrieved using the following command:
  # gdircolors -c ~/.dircolors/dircolors.ansi-dark
  if command -v gdircolors >/dev/null 2>&1; then
    eval "$(gdircolors -b ~/.dircolors/dircolors.ansi-dark)"
  else
    eval "$(dircolors -b ~/.dircolors/dircolors.ansi-dark)"
  fi
# }}}
