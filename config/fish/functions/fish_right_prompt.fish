function fish_right_prompt
  # NOTE: show git branch
  # set_color brgreen; echo (command git rev-parse --abbrev-ref HEAD 2>/dev/null)

  # NOTE: show command duration
  # set_color brgreen; echo $CMD_DURATION | humanize_duration

  # NOTE: directory segment {{{
  set -l pwd (prompt_pwd)
  set -l segments (string split / $pwd)
  set -l prefix (string join / $segments[1..-2])
  set -l tail $segments[-1]
  # }}}

  set_color brgreen; printf "$prefix/"
  set_color --bold brblue; printf "$tail  "
end
