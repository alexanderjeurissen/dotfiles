function fish_prompt
  set -l last_status $status
  set -l prompt_char '$'
  set -l prompt_status_color 'blue'

  set_color normal
  printf "\n "

  # NOTE: set prompt char for when in an active SSH session
  if [ -n "$SSH_CLIENT" ] && [ -n "$SSH_TTY" ]
    set prompt_char '@'
  end

  # NOTE: set prompt char for when ROOT
  if test (id -u) -eq 0
    set prompt_status_color 'magenta'
    set prompt_char '#'
  end

  # NOTE: set prompt color based on being in a git repo
  if test -e .git
    set prompt_char ''
    set -l vcs_status (git diff-index --quiet HEAD -- && echo 0 || echo 1)

    if test $vcs_status -eq 0
      set prompt_status_color 'blue'
    else
      set prompt_char ''
      set prompt_status_color 'yellow'
    end
  end

  # NOTE set prompt color based on last exit status
  if test $last_status -ne 0
    set prompt_status_color 'red'
  end

  set_color --bold "$prompt_status_color"; printf "$prompt_char "

  set_color normal; printf " "
end
