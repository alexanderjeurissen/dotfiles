let g:ale_sign_error = '┃'
let g:ale_sign_warning = '┃'

let g:ale_linters = {
  \   'javascript': ['eslint'],
  \   'jsx': ['stylelint', 'eslint'],
  \   'ruby': ['rubocop'],
  \   'sh' : ['shellcheck'],
  \   'vim' : ['vint'],
  \   'html' : ['tidy'],
  \   'python' : ['flake8'],
  \   'markdown' : ['mdl']
  \}
let g:ale_fixers = {
      \ 'javascript': ['prettier'],
      \ 'sql': ['sqlfmt'],
      \ 'psql': ['sqlfmt']
      \}
let g:ale_linter_aliases = {'jsx': 'css'}

let g:ale_echo_msg_format = '[#%linter%#] %s [%severity%]'

" NOTE: Don't run linters when opening a file
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1

" NOTE: Don't place signs, but do use the error line highlighting
let g:ale_set_signs = 0

noremap <leader>an :ALENext<CR>
noremap <leader>ap :ALEPrevious<CR>
