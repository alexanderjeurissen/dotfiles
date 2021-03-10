function fish_prompt
  set -l last_status $status
  set -l prompt_char ''
  set -l prompt_status_color 'blue'

  set_color normal
  printf "\n "

  if test -e .git
    set -l vcs_status (git diff-index --quiet HEAD -- && echo 0 || echo 1)
    # set prompt_char ''

    if test $vcs_status -eq 0
      set prompt_status_color 'green'
    else
      set prompt_status_color 'yellow'
    end
  end

  if test $last_status -ne 0
    set prompt_status_color 'red'
  end

  set_color --bold "$prompt_status_color"; printf "$prompt_char "

  set_color normal; printf " "
end
