function fish_prompt
  set -l last_status $status

  set_color normal
  printf " "

  # NOTE: directory segment
  set -l pwd (prompt_pwd)
  set -l segments (string split / $pwd)
  set -l prefix (string join / $segments[1..-2])

  set_color brgreen; printf "$prefix/"

  if test -e .git
    set -gx git_status (git status 2> /dev/null)

    if string match -q -- "*nothing to commit*" $git_status
      set_color --bold blue; printf "$segments[-1]"
    else if string match -q -- "*Changes to be committed*" $git_status
      set_color --bold green; printf "$segments[-1]"
    else
      set_color --bold yellow; printf "$segments[-1]"
    end
  else
    set_color --bold white; printf "$segments[-1]"
  end

  set_color normal; printf " "
end
