# CodeWhisperer pre block. Keep at the top of this file.
# [[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh"

# NOTE: zsh config profiling
# zmodload zsh/zprof


# Allow expanding commands using C-e
bindkey -e
bindkey "^E" forward-char

# History settings {{{
  SAVEHIST=1000000000
  HISTFILE=~/.zsh_history
# }}}

# Disables greeting
unsetopt correct_all

export DEFAULT_USER=$USER
export EDITOR='nvim'
export HSANDBOX_EDITOR='nvim'

export HOMEBREW_PREFIX="/opt/homebrew" # lookup using (brew --prefix)

# Misc env variables
export TZ_LIST='Europe/Amsterdam,America/New_York,America/Los_Angeles'

# H1 related env variables
export SKIP_WAIT=1
export LINT_STAGED=1
export PULL_LOCK=1
export POSTGRES_USERNAME='alexanderjeurissenlocal'
export POSTGRES_PASSWORD='hunter3'
export TAILWIND_MODE='watch'
export HACKERONE_ON_DOCKER=true
# export IN_HACKERONE_ON_DOCKER=true

# Emacs / GCC related env variables
export BEORG_PATH="$HOME/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents"

# export LIBRARY_PATH="/opt/homebrew/opt/gcc/lib/gcc/$(gcc -dumpversion)/"
# export LD_LIBRARY_PATH="/opt/homebrew/opt/gcc/lib/gcc/$(gcc -dumpversion)/"

# Set ripgrep rc file
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# Set path {{{
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/opt:$PATH"
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
export LDFLAGS="-L$HOMEBREW_PREFIX/opt/ruby@3.1/lib"
export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/ruby@3.1/include"
export PATH="$HOMEBREW_PREFIX/opt/ruby@3.1/bin:$PATH"
export PATH="$HOMEBREW_PREFIX/lib/ruby/gems/3.1.0/bin:$PATH"
# }}}

# Lua settings (derived from $ luarocks path)
export LUA_PATH="$HOMEBREW_PREFIX/Cellar/luarocks/3.9.1/share/lua/5.4/?.lua;"
export LUA_PATH="$LUA_PATH$HOMEBREW_PREFIX/share/lua/5.4/?.lua;$HOMEBREW_PREFIX/share/lua/5.4/?/init.lua;$HOMEBREW_PREFIX/lib/lua/5.4/?.lua;"
export LUA_PATH="$LUA_PATH$HOMEBREW_PREFIX/lib/lua/5.4/?/init.lua;./?.lua;./?/init.lua;$HOME/.luarocks/share/lua/5.4/?.lua;$HOME/.luarocks/share/lua/5.4/?/init.lua"
export LUA_CPATH="$HOMEBREW_PREFIX/lib/lua/5.4/?.so;$HOMEBREW_PREFIX/lib/lua/5.4/loadall.so;./?.so;$HOME/.luarocks/lib/lua/5.4/?.so"
export PATH="$HOME/.luarocks/bin:$PATH"

# Java settings
# export JAVA_HOME="/usr/libexec/java_home"
# export MAVENPATH="$HOME/.maven"
# export PATH="$MAVENPATH/bin:$PATH"

# FZF settings {{{
bindkey -r "^T"
bindkey -M emacs '^F' fzf-file-widget
bindkey -M vicmd '^F' fzf-file-widget
bindkey -M viins '^F' fzf-file-widget

__fsel_branch() {
  local branches=$(git branch -vv)
  setopt localoptions pipefail no_aliases 2> /dev/null
  local branch_name
  echo "$branches" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --ansi --tac --query=${LBUFFER} ${FZF_DEFAULT_OPTS-} ${FZF_BRANCH_OPTS-}" $(__fzfcmd) | awk '{print $1}' | while read -r branch_name; do
    echo "$branch_name"
  done
  local ret=$?
  echo
  return $ret
}

fzf-branch-widget() {
  LBUFFER="${LBUFFER}$(__fsel_branch)"
  local ret=$?
  zle reset-prompt
  return $ret
}

zle -N fzf-branch-widget
bindkey -r "^B"
bindkey -M emacs '^B' fzf-branch-widget
bindkey -M vicmd '^B' fzf-branch-widget
bindkey -M viins '^B' fzf-branch-widget

export FZF_DEFAULT_OPTS='--color=bw,border:0,info:2,prompt:12,fg:,bg+:0,fg+:,gutter:0 --height 40% --reverse --prompt="  " --border=none --no-separator --no-scrollbar'
export _ZO_FZF_OPTS="--height 40% --reverse $FZF_DEFAULT_OPTS"
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND='rg --files'
# }}}

# LS colors settings {{{
  # retrieved using the following command:
  # gdircolors -c ~/.dircolors/dircolors.ansi-dark
  export LS_COLORS="no=00:fi=00:di=34:ow=34;40:ln=35:pi=30;44:so=35;44:do=35;44:bd=33;44:cd=37;44:or=05;37;41:mi=05;37;41:ex=01;31:*.cmd=01;31:*.exe=01;31:*.com=01;31"
  export LS_COLORS="$LS_COLORS:*.bat=01;31:*.reg=01;31:*.app=01;31:*.txt=32:*.org=32:*.md=32:*.mkd=32:*.h=32:*.hpp=32:*.c=32:*.C=32:*.cc=32:*.cpp=32:*.cxx=32:*.objc=32"
  export LS_COLORS="$LS_COLORS:*.cl=32:*.sh=32:*.bash=32:*.csh=32:*.zsh=32:*.el=32:*.vim=32:*.java=32:*.pl=32:*.pm=32:*.py=32:*.rb=32:*.hs=32:*.php=32:*.htm=32:*.html=32"
  export LS_COLORS="$LS_COLORS:*.shtml=32:*.erb=32:*.haml=32:*.xml=32:*.rdf=32:*.css=32:*.sass=32:*.scss=32:*.less=32:*.js=32:*.coffee=32:*.man=32:*.0=32:*.1=32:*.2=32"
  export LS_COLORS="$LS_COLORS:*.3=32:*.4=32:*.5=32:*.6=32:*.7=32:*.8=32:*.9=32:*.l=32:*.n=32:*.p=32:*.pod=32:*.tex=32:*.go=32:*.sql=32:*.csv=32:*.sv=32:*.svh=32:*.v=32"
  export LS_COLORS="$LS_COLORS:*.vh=32:*.vhd=32:*.bmp=33:*.cgm=33:*.dl=33:*.dvi=33:*.emf=33:*.eps=33:*.gif=33:*.jpeg=33:*.jpg=33:*.JPG=33:*.mng=33:*.pbm=33:*.pcx=33"
  export LS_COLORS="$LS_COLORS:*.pdf=33:*.pgm=33:*.png=33:*.PNG=33:*.ppm=33:*.pps=33:*.ppsx=33:*.ps=33:*.svg=33:*.svgz=33:*.tga=33:*.tif=33:*.tiff=33:*.xbm=33:*.xcf=33"
  export LS_COLORS="$LS_COLORS:*.xpm=33:*.xwd=33:*.xwd=33:*.yuv=33:*.nef=33:*.NEF=33:*.aac=33:*.au=33:*.flac=33:*.m4a=33:*.mid=33:*.midi=33:*.mka=33:*.mp3=33:*.mpa=33"
  export LS_COLORS="$LS_COLORS:*.mpeg=33:*.mpg=33:*.ogg=33:*.opus=33:*.ra=33:*.wav=33:*.anx=33:*.asf=33:*.avi=33:*.axv=33:*.flc=33:*.fli=33:*.flv=33:*.gl=33:*.m2v=33"
  export LS_COLORS="$LS_COLORS:*.m4v=33:*.mkv=33:*.mov=33:*.MOV=33:*.mp4=33:*.mp4v=33:*.mpeg=33:*.mpg=33:*.nuv=33:*.ogm=33:*.ogv=33:*.ogx=33:*.qt=33:*.rm=33:*.rmvb=33"
  export LS_COLORS="$LS_COLORS:*.swf=33:*.vob=33:*.webm=33:*.wmv=33:*.doc=31:*.docx=31:*.rtf=31:*.odt=31:*.dot=31:*.dotx=31:*.ott=31:*.xls=31:*.xlsx=31:*.ods=31"
  export LS_COLORS="$LS_COLORS:*.ots=31:*.ppt=31:*.pptx=31:*.odp=31:*.otp=31:*.fla=31:*.psd=31:*.7z=1;35:*.apk=1;35:*.arj=1;35:*.bin=1;35:*.bz=1;35:*.bz2=1;35"
  export LS_COLORS="$LS_COLORS:*.cab=1;35:*.deb=1;35:*.dmg=1;35:*.gem=1;35:*.gz=1;35:*.iso=1;35:*.jar=1;35:*.msi=1;35:*.rar=1;35:*.rpm=1;35:*.tar=1;35:*.tbz=1;35"
  export LS_COLORS="$LS_COLORS:*.tbz2=1;35:*.tgz=1;35:*.tx=1;35:*.war=1;35:*.xpi=1;35:*.xz=1;35:*.z=1;35:*.Z=1;35:*.zip=1;35:*.zst=1;35:*.ANSI-30-black=30"
  export LS_COLORS="$LS_COLORS:*.ANSI-01;30-brblack=01;30:*.ANSI-31-red=31:*.ANSI-01;31-brred=01;31:*.ANSI-32-green=32:*.ANSI-01;32-brgreen=01;32:*.ANSI-33-yellow=33"
  export LS_COLORS="$LS_COLORS:*.ANSI-01;33-bryellow=01;33:*.ANSI-34-blue=34:*.ANSI-01;34-brblue=01;34:*.ANSI-35-magenta=35:*.ANSI-01;35-brmagenta=01;35"
  export LS_COLORS="$LS_COLORS:*.ANSI-36-cyan=36:*.ANSI-01;36-brcyan=01;36:*.ANSI-37-white=37:*.ANSI-01;37-brwhite=01;37:*.log=01;32:*~=01;32:*#=01;32:*.bak=01;33"
  export LS_COLORS="$LS_COLORS:*.BAK=01;33:*.old=01;33:*.OLD=01;33:*.org_archive=01;33:*.off=01;33:*.OFF=01;33:*.dist=01;33:*.DIST=01;33:*.orig=01;33:*.ORIG=01;33"
  export LS_COLORS="$LS_COLORS:*.swp=01;33:*.swo=01;33:*.v=01;33:*.gpg=34:*.gpg=34:*.pgp=34:*.asc=34:*.3des=34:*.aes=34:*.enc=34:*.sqlite=34"
# }}}

# Plugins {{{
  if type brew &>/dev/null; then
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # TODO: zsh-syntax-highlighting significantly slows down the shell
    # source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  fi
# }}}

# Vi settings {{{
  bindkey -v
# }}

source ~/.zsh_aliases
'builtin' 'source' ~/.zsh_prompt
source ~/.zsh_keybindings
# vim: foldmethod=marker:sw=2:foldlevel=10
#

# Initialize zoxide (improved cd)
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
# NOTE: profile zsh config
# zprof

# CodeWhisperer post block. Keep at the bottom of this file.
# [[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh"
