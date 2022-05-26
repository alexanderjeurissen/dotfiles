require('telescope').setup{
  defaults = {
    layout_strategy = 'flex',
    mappings = {
      i = {
        -- close in insert mode
        ['<esc>'] = require('telescope.actions').close
      }
    }
  }
}

require('telescope').load_extension('fzy_native')
