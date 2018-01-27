let g:grepper = {} " initialize g:grepper with empty dictionary
let g:grepper.tools = ['rg', 'ag', 'git', 'grep']
let g:grepper.jump = 1
let g:grepper.stop = 100

nnoremap <silent> <leader>/ :<C-u>Grepper<CR>
