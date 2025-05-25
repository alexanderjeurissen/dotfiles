local vim = vim or {}
local Util = require('util')
local imap = Util.imap

vim.opt_local.spell = true

-- setlocal omnifunc=htmlcomplete#CompleteTags
vim.opt_local.complete = vim.bo.complete .. ',kspell'

-- imap('<c-l>' [[<Esc>[s1z=`]a]], {}, true)

-- Allow for folding markdown headings
vim.g.markdown_folding = 1

