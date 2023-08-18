# NOTE: init zoxide (improved cd)
zoxide init fish | source

# NOTE: allow expanding commands using C-e
bind -M insert \cE forward-char

# NOTE: disables "Welcome to Fish" greeting
set fish_greeting

set -gx DEFAULT_USER $USER
set -gx EDITOR 'nvim'
set -gx HSANDBOX_EDITOR 'nvim'

set -gx HOMEBREW_PREFIX "/opt/homebrew" # lookup using (brew --prefix)

# NOTE: misc env variables {{{
set -gx TZ_LIST 'Europe/Amsterdam,America/New_York,America/Los_Angeles'
# }}}

# NOTE: H1 related env variables {{{
  set -gx SKIP_WAIT 1
  set -gx LINT_STAGED 1
  set -gx PULL_LOCK 1
  set -gx POSTGRES_USERNAME 'alexanderjeurissenlocal'
  set -gx POSTGRES_PASSWORD 'hunter3'
  set -gx TAILWIND_MODE watch
  set -gx HACKERONE_ON_DOCKER true
# }}}

# NOTE: set ripgrep rc file
set -gx RIPGREP_CONFIG_PATH "$HOME/.ripgreprc"

# NOTE: set path {{{
set PATH "$HOME/.bin" $PATH # TODO: evaluate env var
set PATH "$HOME/bin" $PATH # NOTE: linux usr bin
set PATH "$HOME/.local/bin" $PATH # NOTE: linux usr bin
set PATH "$HOME/.local/opt" $PATH # NOTE: webi installs
set PATH "$HOME/.scripts" $PATH # include my own scripts

set PATH "$HOME/.yarn/bin" $PATH
set PATH "$HOME/.cargo/bin" $PATH
# }}}

# NOTE: Go path settings {{{
  set -gx GOPATH "$HOME/Development/go"
  set PATH "$GOPATH/bin" $PATH
# }}}

# NOTE: Ruby settings {{{
  set -gx ENABLE_SPRING 0
  set -gx LDFLAGS "-L$HOMEBREW_PREFIX/opt/ruby@3.1/lib"
  set -gx CPPFLAGS "-I$HOMEBREW_PREFIX/opt/ruby@3.1/include"
  set PATH "$HOMEBREW_PREFIX/lib/ruby/gems/3.1.0" $PATH
# }}}

# NOTE: Lua settings (derived from $ luarocks path) {{{
  set LUA_PATH "$HOMEBREW_PREFIX/Cellar/luarocks/3.9.1/share/lua/5.4/?.lua;$HOMEBREW_PREFIX/share/lua/5.4/?.lua;$HOMEBREW_PREFIX/share/lua/5.4/?/init.lua;$HOMEBREW_PREFIX/lib/lua/5.4/?.lua;$HOMEBREW_PREFIX/lib/lua/5.4/?/init.lua;./?.lua;./?/init.lua;$HOME/.luarocks/share/lua/5.4/?.lua;$HOME/.luarocks/share/lua/5.4/?/init.lua"
  set LUA_CPATH "$HOMEBREW_PREFIX/lib/lua/5.4/?.so;$HOMEBREW_PREFIX/lib/lua/5.4/loadall.so;./?.so;$HOME/.luarocks/lib/lua/5.4/?.so"
  set PATH "$HOME/.luarocks/bin" $PATH
# }}}

# NOTE: Java settings {{{
  # set -gx JAVA_HOME (/usr/libexec/java_home)
  # set -gx MAVENPATH $HOME/.maven
  # set PATH $PATH "$MAVENPATH/bin"
# }}}

# FZF settings {{{
 set -gx FZF_DEFAULT_OPTS '--color=bw,border:0,info:2,prompt:12,fg:,bg+:0,fg+:,gutter:0 --height 40% --reverse --prompt="  " --border=none --no-separator --no-scrollbar'

 set -gx _ZO_FZF_OPTS "--height 40% --reverse $FZF_DEFAULT_OPTS"
 set -gx FZF_DEFAULT_COMMAND 'rg --files'
 set -gx FZF_CTRL_T_COMMAND 'rg --files'
# }}}

# LS colors settings {{{
  # retrieved using the following command:
  # $ gdircolors -c ~/.dircolors/dircolors.ansi-dark
  setenv LS_COLORS 'no=00:fi=00:di=34:ow=34;40:ln=35:pi=30;44:so=35;44:do=35;44:bd=33;44:cd=37;44:or=05;37;41:mi=05;37;41:ex=01;31:*.cmd=01;31:*.exe=01;31:*.com=01;31:*.bat=01;31:*.reg=01;31:*.app=01;31:*.txt=32:*.org=32:*.md=32:*.mkd=32:*.h=32:*.hpp=32:*.c=32:*.C=32:*.cc=32:*.cpp=32:*.cxx=32:*.objc=32:*.cl=32:*.sh=32:*.bash=32:*.csh=32:*.zsh=32:*.el=32:*.vim=32:*.java=32:*.pl=32:*.pm=32:*.py=32:*.rb=32:*.hs=32:*.php=32:*.htm=32:*.html=32:*.shtml=32:*.erb=32:*.haml=32:*.xml=32:*.rdf=32:*.css=32:*.sass=32:*.scss=32:*.less=32:*.js=32:*.coffee=32:*.man=32:*.0=32:*.1=32:*.2=32:*.3=32:*.4=32:*.5=32:*.6=32:*.7=32:*.8=32:*.9=32:*.l=32:*.n=32:*.p=32:*.pod=32:*.tex=32:*.go=32:*.sql=32:*.csv=32:*.sv=32:*.svh=32:*.v=32:*.vh=32:*.vhd=32:*.bmp=33:*.cgm=33:*.dl=33:*.dvi=33:*.emf=33:*.eps=33:*.gif=33:*.jpeg=33:*.jpg=33:*.JPG=33:*.mng=33:*.pbm=33:*.pcx=33:*.pdf=33:*.pgm=33:*.png=33:*.PNG=33:*.ppm=33:*.pps=33:*.ppsx=33:*.ps=33:*.svg=33:*.svgz=33:*.tga=33:*.tif=33:*.tiff=33:*.xbm=33:*.xcf=33:*.xpm=33:*.xwd=33:*.xwd=33:*.yuv=33:*.nef=33:*.NEF=33:*.aac=33:*.au=33:*.flac=33:*.m4a=33:*.mid=33:*.midi=33:*.mka=33:*.mp3=33:*.mpa=33:*.mpeg=33:*.mpg=33:*.ogg=33:*.opus=33:*.ra=33:*.wav=33:*.anx=33:*.asf=33:*.avi=33:*.axv=33:*.flc=33:*.fli=33:*.flv=33:*.gl=33:*.m2v=33:*.m4v=33:*.mkv=33:*.mov=33:*.MOV=33:*.mp4=33:*.mp4v=33:*.mpeg=33:*.mpg=33:*.nuv=33:*.ogm=33:*.ogv=33:*.ogx=33:*.qt=33:*.rm=33:*.rmvb=33:*.swf=33:*.vob=33:*.webm=33:*.wmv=33:*.doc=31:*.docx=31:*.rtf=31:*.odt=31:*.dot=31:*.dotx=31:*.ott=31:*.xls=31:*.xlsx=31:*.ods=31:*.ots=31:*.ppt=31:*.pptx=31:*.odp=31:*.otp=31:*.fla=31:*.psd=31:*.7z=1;35:*.apk=1;35:*.arj=1;35:*.bin=1;35:*.bz=1;35:*.bz2=1;35:*.cab=1;35:*.deb=1;35:*.dmg=1;35:*.gem=1;35:*.gz=1;35:*.iso=1;35:*.jar=1;35:*.msi=1;35:*.rar=1;35:*.rpm=1;35:*.tar=1;35:*.tbz=1;35:*.tbz2=1;35:*.tgz=1;35:*.tx=1;35:*.war=1;35:*.xpi=1;35:*.xz=1;35:*.z=1;35:*.Z=1;35:*.zip=1;35:*.zst=1;35:*.ANSI-30-black=30:*.ANSI-01;30-brblack=01;30:*.ANSI-31-red=31:*.ANSI-01;31-brred=01;31:*.ANSI-32-green=32:*.ANSI-01;32-brgreen=01;32:*.ANSI-33-yellow=33:*.ANSI-01;33-bryellow=01;33:*.ANSI-34-blue=34:*.ANSI-01;34-brblue=01;34:*.ANSI-35-magenta=35:*.ANSI-01;35-brmagenta=01;35:*.ANSI-36-cyan=36:*.ANSI-01;36-brcyan=01;36:*.ANSI-37-white=37:*.ANSI-01;37-brwhite=01;37:*.log=01;32:*~=01;32:*#=01;32:*.bak=01;33:*.BAK=01;33:*.old=01;33:*.OLD=01;33:*.org_archive=01;33:*.off=01;33:*.OFF=01;33:*.dist=01;33:*.DIST=01;33:*.orig=01;33:*.ORIG=01;33:*.swp=01;33:*.swo=01;33:*.v=01;33:*.gpg=34:*.gpg=34:*.pgp=34:*.asc=34:*.3des=34:*.aes=34:*.enc=34:*.sqlite=34:'
# }}}
# vim: foldmethod=marker:sw=2:foldlevel=10

