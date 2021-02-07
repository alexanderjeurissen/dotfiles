require "ido"
local cmd = vim.api.nvim_command

-- NOTE: horizontal mode {{{
  ido_decorations['separator']   = ' | '
  ido_decorations['matchstart']  = '{ '
  ido_decorations['matchend']    = ' }'
  ido_decorations['marker']      = ' > '
  ido_decorations['moreitems']   = '...'
  ido_limit_lines                = true
  -- ido_minimal_mode               = true
  ido_overlap_statusline         = true
-- }}}

-- NOTE: vertical mode {{{
  --[[ ido_decorations['separator']   = '\n    '
  ido_decorations['matchstart']  = '\n'
  ido_decorations['matchend']  = '\n'
  ido_decorations['marker']      = ' > '
  ido_decorations['moreitems']   = ''
  ido_limit_lines                = false ]]
-- }}}

cmd('hi! IdoCursor         ctermfg=8 ctermbg=12')
cmd('hi! IdoSelectedMatch  ctermfg=3')
cmd('hi! IdoPrefix         ctermfg=3')
cmd('hi! IdoSeparator      ctermfg=7')
cmd('hi! IdoPrompt         ctermfg=4')
cmd('hi! IdoWindow         ctermbg=0')
