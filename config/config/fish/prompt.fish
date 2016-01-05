## BEGIN GIT STUFF
set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set red (set_color red)
set gray (set_color -o black)


# Fish git prompt
set __fish_git_prompt_show_informative_status 'yes'
set __fish_git_prompt_showstashstate 'yes'

#Fish git colors
set __fish_git_prompt_color_branch 62A
set __fish_git_prompt_color_dirtystate blue
set __fish_git_prompt_color_stagedstate green
set __fish_git_prompt_color_untrackedfiles yellow

set __fish_git_prompt_color_stashstate yellow

set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red
set __fish_git_prompt_color_upstream_equal normal
set __fish_git_prompt_color_merging yellow

# Status Chars
# ✖ ➜ ═ 
set __fish_git_prompt_char_branch '  '
set __fish_git_prompt_char_dirtystate ' ✹ '
set __fish_git_prompt_char_stagedstate ' ✚ '
set __fish_git_prompt_char_untrackedfiles ' ✭ '

set __fish_git_prompt_char_stashstate ' ⚑ '

set __fish_git_prompt_char_upstream_ahead ' ↑ '
set __fish_git_prompt_char_upstream_behind ' ↓ '
set __fish_git_prompt_char_upstream_diverged ' x '
set __fish_git_prompt_char_upstream_equal ' ✔ '

set __fish_git_prompt_char_invalidstate ' ↩ '

function fish_prompt
  set mode_str (
    # echo -n " "
    switch $fish_bind_mode
        case default
            set_color --bold red
            echo -n "●"
        case insert
            set_color --bold green
            echo -n "❯"
        case visual
            set_color --bold magenta
            echo -n "❮"
    end
    set_color normal
  )
  set last_status $status
  set_color $fish_color_cwd
  printf '%s' (prompt_pwd) \n
  set_color normal
  printf '%s' (__fish_git_prompt)
  printf '%s' $mode_str
  set_color magenta
  printf '%s❯ '
  set_color normal
end
