__process_settings() {
  case $(uname -s) in
    *Darwin*)
      boot=$(sysctl -q -n kern.boottime | awk -F'[ ,:]+' '{ print $4 }')
      now=$(date +%s)
      ;;
    *Linux*|*CYGWIN*)
      now=$(cut -d' ' -f1 < /proc/uptime)
      ;;
    *OpenBSD*)
      boot=$(sysctl -n kern.boottime)
      now=$(date +%s)
  esac
  export TMUX_POWERLINE_SEG_UPTIME_BOOT=$boot
  export TMUX_POWERLINE_SEG_UPTIME_NOW=$now
}

run_segment() {
    __process_settings
    uptime=$(expr ${TMUX_POWERLINE_SEG_UPTIME_NOW} - ${TMUX_POWERLINE_SEG_UPTIME_BOOT})
    d=$(expr $uptime / 86400)
    h=$(expr $uptime / 3600 % 24)
    m=$(expr $uptime / 60 % 60)
    # printf " %sd %sh %sm" "$d" "$h" "$m"
    printf " %sd %sh" "$d" "$h"
    return 0
}
