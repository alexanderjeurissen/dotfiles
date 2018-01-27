" Automatically start language servers.
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {}
let g:LanguageClient_diagnosticsEnable = 1

" gd to go to definition
nnoremap <silent>gd :call LanguageClient_textDocument_definition()<CR>
" K for type info under cursor
nnoremap <silent>K :call LanguageClient_textDocument_hover()<CR>
" <leader>lr to rename variable under cursor
" nnoremap <leader>lr :call LanguageClient_textDocument_rename()<cr>

" <leader>ls to fuzzy search symbols in current buffer
nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <leader>lr :call LanguageClient_textDocument_references()<CR>

"LANGSERVER: Javascript / Typescript {{{
if !executable('javascript-typescript-stdio')
  echohl WarningMsg | echom "javascript lang server not installed" | echohl None
  exec '!yarn global add javascript-typescript-langserver'
else
  " Use LanguageServer for omnifunc completion
  let g:LanguageClient_serverCommands.javascript = ['javascript-typescript-stdio']
  let g:LanguageClient_serverCommands['javascript.jsx'] = ['javascript-typescript-stdio']
endif

if !executable('language_server-ruby')
  echohl WarningMsg | echom "ruby lang server not installed" | echohl None
  exec '!gem install language_server'
else
  " Use LanguageServer for omnifunc completion
  let g:LanguageClient_serverCommands.ruby = ['language_server-ruby']
endif
" }}}
