_display_progress() {
  local time_remaining=$1
  local time_val=`echo "$time_remaining" | tr -d ':' | bc`
  local divider=500

  local filled_segments=$(($time_val / $divider))
  local empty_segments=$((5-$filled_segments))
  local active_segments=''
  local remainder=$(($time_val % $divider))

  # The glyphs that will be used to indicate the progress
  local filled_glyph=' '
  local empty_glyph=' '
  local active_glyph=' '

  if (($time_val == 0)); then
    echo "☕POMO COMPLETE"
    $(tmux display-message -p "☕POMO COMPLETE")
  else
    if (($remainder > 0)); then
      empty_segments=$(($empty_segments-1))
      active_segments="$active_glyph"
    fi

    filled_segments=`printf "%${filled_segments}s"`
    empty_segments=`printf "%${empty_segments}s"`
    echo "${filled_segments// /$filled_glyph}$active_segments${empty_segments// /$empty_glyph}" |
      sed 's/^[[:space:]]*//;s/[[:space:]]*$//'
  fi
}

run_segment() {
  time_remaining=`pom status`

  if [[ $time_remaining == '--:--' ]]; then
    echo " NO POMODORO"
  else
    echo "$(_display_progress $time_remaining)"
    # Include minutes:seconds section
    # echo "$(_display_tomatoes $time_remaining)  $time_remaining"
  fi

  # other fun characters:
  # coffee: ☕
  # lifes:  
  # circles    
  # tomatoes:   
  # squares:       □ ■
  # stars:   
  # fills / progressbar ▓▓▒▒▒▒ ░
  # times $filled_segments echo 'str'
  # echo "$filled_segments"
}


