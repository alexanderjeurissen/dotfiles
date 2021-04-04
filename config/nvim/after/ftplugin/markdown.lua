local vim = vim or {}
local Util = require('util')
local imap = Util.imap

vim.wo.spell = true

-- setlocal omnifunc=htmlcomplete#CompleteTags
vim.bo.complete = vim.bo.complete .. ',kspell'

imap('<c-l>' [[<Esc>[s1z=`]a]], {}, true)

-- Disable marking of margin (colorcolumn)
vim.call('general#MarkMargin', 0)

-- Allow for folding markdown headings
vim.g.markdown_folding = 1

