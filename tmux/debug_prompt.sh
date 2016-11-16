# The segments shown here are for debug purposes
# Enable DEBUG_MODE and DEBUG_VCS accordingly to test the looks and
# functionality

# $(tmux display-message ${TMUX_PANE_WIDTH}) # show the pane_width
double_segment "♫" black blue "debug/song" blue brightblue 143
double_segment "js" black yellow "debug/version" yellow brightyellow 113
double_segment "rb" black red "debug/version" red brightred 113
if [ $DEBUG_VCS -eq 1 ]; then
  double_segment "⎇" black brightred "debug/branch" black brightred
  segment "debug/compare" black brightgreen
  double_segment "⊕" black green "debug/int" black brightgreen
  double_segment "+" black yellow "debug/int" black brightyellow
  double_segment "○" black cyan "debug/int" black brightcyan
fi
