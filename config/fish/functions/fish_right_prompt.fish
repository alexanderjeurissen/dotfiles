function fish_right_prompt
  # NOTE: exit status segment
  set -l last_status $status

  set_color brgreen; echo (command git rev-parse --abbrev-ref HEAD 2>/dev/null)

  if test $last_status -eq 0
    set_color --bold green; printf "  "
  else
    set_color --bold red; printf "  "
  end
end
