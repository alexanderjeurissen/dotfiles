 tnoremap <C-h> <C-\><C-n><C-w>h
 tnoremap <C-j> <C-\><C-n><C-w>j
 tnoremap <C-k> <C-\><C-n><C-w>k
 tnoremap <C-l> <C-\><C-n><C-w>l
 noremap <C-h> <C-w>h
 noremap <C-j> <C-w>j
 noremap <C-k> <C-w>k
 noremap <C-l> <C-w>l
 inoremap <C-h> <Esc><C-w>h
 inoremap <C-j> <Esc><C-w>j
 inoremap <C-k> <Esc><C-w>k
 inoremap <C-l> <Esc><C-w>l

 let g:nvimux_open_term_by_default = 1

" lua << EOF
"  local nvimux = require('nvimux')

"  -- Nvimux configuration
"  nvimux.config.set_all{
"    prefix = '<C-a>',
"    open_term_by_default = true,
"    new_window_buffer = 'single',
"    quickterm_direction = 'botright',
"    quickterm_orientation = 'vertical',
"    -- Use 'g' for global quickterm
"    quickterm_scope = 't',
"    quickterm_size = '80',
"  }

"  -- Nvimux custom bindings
"  nvimux.bindings.bind_all{
"    {'s', ':NvimuxHorizontalSplit', {'n', 'v', 'i', 't'}},
"    {'v', ':NvimuxVerticalSplit', {'n', 'v', 'i', 't'}},
"  }
" EOF
