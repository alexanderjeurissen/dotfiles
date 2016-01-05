# color stuff
set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set red (set_color red)
set gray (set_color -o black)

set POWERLINE_SEPARATOR_LEFT_BOLD="⮂"
set POWERLINE_SEPARATOR_LEFT_THIN="⮃"
set POWERLINE_SEPARATOR_RIGHT_BOLD="⮀"
set POWERLINE_SEPARATOR_RIGHT_THIN="⮁"


function fish_prompt -d "display the prompt including all segments"
    source ~/.config/fish/prompt/segments/vcs_branch.sh
end
