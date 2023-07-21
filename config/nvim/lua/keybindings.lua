local Util = require('util')

local nmap = Util.nmap
local vmap = Util.vmap
local imap = Util.imap
local map = vim.keymap.set

local noremap = Util.noremap
local nnoremap = Util.nnoremap
local vnoremap = Util.vnoremap
local xnoremap = Util.xnoremap

nnoremap('n', [[nzz:lua require('general').hl_next(100)<cr>]])
nnoremap('N', [[Nzz:lua require('general').hl_next(100)<cr>]])

-- Open highlighted text with default program
vnoremap('o', [[:call general#ExecVisualSelection()<cr>]])

-- KEYBINDINGS: Editing {{{
  xnoremap('@', [[:<C-u>call general#ExecuteMacroOverVisualRange()<CR>]])

  -- Move visual block
  vnoremap('J', [[:m '>+1<CR>gv=gv]])
  vnoremap('K', [[:m '<-2<CR>gv=gv]])

  -- custom comma motion mapping
  nnoremap('di,', [[f,dT,]])
  nnoremap('ci,', [[f,cT,]])

  -- (upper|lower)case word under cursor
  nnoremap('g^', [[gUiW]])
  nnoremap('gv', [[guiW]])

  -- Create newline before/after current row
  nnoremap('go', [[o<ESC>k]])
  nnoremap('gO', [[O<ESC>j]])

  -- Paste and keep pasting same thing, don't take what was removed
  vnoremap('<leader>p', [["_dP]])

  -- Make Y behave like other capital commands.
  -- Hat-tip http://vimbits.com/bits/11
  nnoremap('Y', [[y$]])

  -- keep selection after indent
  vnoremap('<', [[<gv]])
  vnoremap('>', [[>gv]])

  imap('<c-h>', [[<c-o>x]])
-- }}}

-- KEYBINDINGS: Navigation / Search {{{
  -- Go to previous and next item in quickfix list
  noremap(' cw', [[:cwindow<CR><C-w>J]])
  noremap(' cq', [[<C-w><C-p>:cclose<CR>]])
  noremap(' cn', [[:cnext<CR>]])
  noremap(' cN', [[:cnfile<CR>]])
  noremap(' cp', [[:cprev<CR>]])
  noremap(' cP', [[:cpfile<CR>]])

  noremap(' ln', [[:lnext<CR>]])
  noremap(' lN', [[:lnfile<CR>]])
  noremap(' lp', [[:lprev<CR>]])
  noremap(' lP', [[:lpfile<CR>]])

  -- Split creation
  noremap(' wv', [[<C-w>v]])
  noremap(' ws', [[<C-w>s]])

  -- Split resizing
  nmap('<left>', [[<C-w>5<]])
  nmap('<up>', [[<C-w>5+]])
  nmap('<down>', [[<C-w>5-]])
  nmap('<right>', [[<C-w>5>]])

  -- Split navigation
  nnoremap('<c-h>', [[<C-w><left>]])
  nnoremap('<c-j>', [[<C-w><down>]])
  nnoremap('<c-k>', [[<C-w><up>]])
  nnoremap('<c-l>', [[<C-w><right>]])
  nnoremap([[<c-\>]], [[<C-w><w>]])

  -- Disable arrows and BS in insert mode
  imap('<left>', [[<nop>]])
  imap('<up>', [[<nop>]])
  imap('<down>', [[<nop>]])
  imap('<right>', [[<nop>]])
  imap('<BS>', [[<nop>]])
  imap('<DEL>', [[<nop>]])


  -- Wrapped lines goes down/up to next row, rather than next line in file.
  noremap('j', [[gj]])
  noremap('k', [[gk]])

  -- Find merge conflict markers
  noremap('gm', [[/\v^[<\|=>]{7}( .*\|$)<CR>]], { silent = false })

  -- default to very magic
  noremap('/', [[/\v]], { silent = false })
  noremap('?', [[?\v]], { silent = false })

  -- bind <leader>/ to grep
  nnoremap(' /', [[:grep -F ""<LEFT>]], { silent = false })

  -- bind K to grep word under cursor
  nnoremap('K', [[:grep! "\b<C-R><C-W>\b"<CR><CR>:cw<CR>]])

  -- Repurpose the s and S key for search and replace
  nmap('S',  [[:%s//g<LEFT><LEFT>]], { silent = false })
  vmap('s',  [[:Blockwise s//g<LEFT><LEFT>]], { silent = false })

  -- Rebind the old H and L keyt to zh, zl
  nnoremap('zh', [[H]])
  nnoremap('zm', [[M]])
  nnoremap('zl', [[L]])

  -- Repurpose the H and L keys to quickly switch buffers
  nnoremap('H', [[:bp<CR>]])
  nnoremap('L', [[:bn<CR>]])

  nnoremap('zgg', [[:normal 100000000zk<CR>]])
  nnoremap('zG',  [[:normal  100000000zj<CR>]])

  -- auto-center on specific movement keys, and blink current search match
  nnoremap('G', [[Gzz]])
  nnoremap('n', [[nzz:lua require('general').hl_next(100)<cr>]])
  nnoremap('N',  [[Nzz:lua require('general').hl_next(100)<cr>]])
  nnoremap('}', [[}zz]])
  nnoremap('{', [[{zz]])

  map('n', '<C-c>', '<C-c>', { silent = true, noremap = true})
-- }}}


-- vim: foldmethod=marker:sw=2:foldlevel=10
