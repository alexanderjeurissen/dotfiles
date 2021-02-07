local set_keymap = vim.api.nvim_set_keymap

vim.g.tmux_navigator_no_mappings = 0
vim.g.tmux_navigator_save_on_switch = 1

set_keymap('n', '<BS>', ':TmuxNavigateLeft<cr>', { noremap = true, silent = true })

--[[ tnoremap <silent> <c-h> <C-\><C-n>:TmuxNavigateLeft<cr>
tnoremap <silent> <c-j> <C-\><C-n>:TmuxNavigateDown<cr>
tnoremap <silent> <c-k> <C-\><C-n>:TmuxNavigateUp<cr>
tnoremap <silent> <c-l> <C-\><C-n>:TmuxNavigateRight<cr>
tnoremap <silent> <c-\> <C-\><C-n>:TmuxNavigatePrevious<cr> ]]
