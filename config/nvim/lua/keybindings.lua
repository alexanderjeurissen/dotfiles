local Util = require('util')

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
-- }}}

-- FIXME: KEYBINDINGS: Navigation / Search {{{
  -- Go to previous and next item in quickfix list
  noremap('<leader>cw', [[:cwindow<CR><C-w>J]])
  noremap('<leader>cq', [[<C-w><C-p>:cclose<CR>]])
  noremap('<leader>cn', [[:cnext<CR>]])
  noremap('<leader>cN', [[:cnfile<CR>]])
  noremap('<leader>cp', [[:cprev<CR>]])
  noremap('<leader>cP', [[:cpfile<CR>]])

  noremap('<leader>ln', [[:lnext<CR>]])
  noremap('<leader>lN', [[:lnfile<CR>]])
  noremap('<leader>lp', [[:lprev<CR>]])
  noremap('<leader>lP', [[:lpfile<CR>]])

  -- Split creation
  -- noremap <silent> <leader>wv <C-w>v
  -- noremap <silent> <leader>ws <C-w>s

  -- Split resizing
  -- nmap <left> <C-w>5<
  -- nmap <up> <C-w>5+
  -- nmap <down> <C-w>5-
  -- nmap <right> <C-w>5>

  -- Split navigation
  -- noremap <silent> <c-h> <C-w><left>
  -- noremap <silent> <c-j> <C-w><down>
  -- noremap <silent> <c-k> <C-w><up>
  -- noremap <silent> <c-l> <C-w><right>
  -- noremap <silent> <c-\> <C-w><w>

  -- NOTE: disable arrows and BS in insert mode
  -- imap <left> <nop>
  -- imap <up> <nop>
  -- imap <down> <nop>
  -- imap <right> <nop>
  -- imap <BS> <nop>
  --[[ imap <DEL> <nop>
 ]]
  -- Wrapped lines goes down/up to next row, rather than next line in file.
  --[[ noremap j gj
  noremap k gk ]]

  -- Find merge conflict markers
  --[[ noremap <leader>gm /\v^[<\|=>]{7}( .*\|$)<CR>
 ]]
  -- default to very magic
  --[[ noremap / /\v
  noremap ? ?\v ]]

   -- bind <leader>/ to grep
  --[[ nmap <leader>/ :grep -F ""<LEFT>
 ]]
  -- bind K to grep word under cursor
  --[[ nnoremap K :grep! "\b<C-R><C-W>\b"<CR><CR>:cw<CR>
 ]]
  -- Repurpose the s and S key for search and replace
  --[[ nmap S  :%s//g<LEFT><LEFT>
  vmap s  :Blockwise s//g<LEFT><LEFT> ]]

  -- Repurpose the H and L keys to quickly switch buffers
  --[[ nnoremap H :bp<CR>
  nnoremap L :bn<CR> ]]

  -- Rebind the old H and L keyt to zh, zl
  --[[ nnoremap zh H
  nnoremap zm M ]]
  --[[ nnoremap zl L
 ]]
  -- Create some additional fold movements
  --[[ nnoremap zN :normal zC<CR>/^diff --git<CR>:nohl<CR>:normal zA<CR>:normal zt<CR>
  nnoremap zP :normal zC<CR>?^diff --git<CR>:nohl<CR>:normal zA<CR>:normal zt<CR> ]]

  --[[ nnoremap zn :normal zc<CR>/^@@<CR>:nohl<CR>:normal zv<CR>:normal zt<CR>
  nnoremap zp :normal zc<CR>?^@@<CR>:nohl<CR>:normal zv<CR>:normal zb<CR> ]]

  --[[ nnoremap zgg :normal 100000000zk<CR>
  nnoremap zG :normal  100000000zj<CR> ]]

  -- auto-center on specific movement keys, and blink current search match
  --[[ nnoremap G Gzz
  nnoremap <silent>n nzz:lua require('general').hl_next(100)<cr> ]]
  --[[ nnoremap <silent>N Nzz:lua require('general').hl_next(100)<cr>
  nnoremap } }zz ]]
  --[[ nnoremap { {zz
-- }}} ]]


-- vim: foldmethod=marker:sw=2:foldlevel=10
