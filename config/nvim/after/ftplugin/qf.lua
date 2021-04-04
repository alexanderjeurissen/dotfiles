-- Snippets from vim-qf
-- Credits: https://github.com/romainl/vim-qf

local vim = vim or {}
local Util = require('util')
local nnoremap = Util.nnoremap

-- nnoremap('p', [[:call <SID>preview_file()<CR>]], {}, true)
nnoremap('q', [[:pclose!<CR>:quit<CR>]], {}, true)
nnoremap('o', [[<CR><C-w>p]], { silent = false }, true)
nnoremap('o', [[<CR><C-w>p]], { silent = false }, true)

-- FIXME: convert to lua function
--[[ function! s:preview_file()
  let winwidth = &columns
  let cur_list = b:qf_isLoc == 1 ? getloclist('.') : getqflist()
  let cur_line = getline(line('.'))
  let cur_file = fnameescape(substitute(cur_line, '|.*$', '', ''))
  if cur_line =~# '|\d\+'
    let cur_pos  = substitute(cur_line, '^\(.\{-}|\)\(\d\+\)\(.*\)', '\2', '')
    execute 'vertical pedit! +'.cur_pos.' '.cur_file
  else
    execute 'vertical pedit! '.cur_file
  endif
  wincmd P
  execute 'vert resize '.(winwidth / 2)
  wincmd p
endfunction ]]

vim.call('general#MarkMargin', 0)

-- TODO: evaluate if this is needed
-- autocmd BufEnter qf :call general#MarkMargin(0)
