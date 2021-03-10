local nvimux = require('nvimux')

-- Nvimux configuration
nvimux.config.set_all{
  prefix = '<C-t>',
  new_window = 'term', -- Use 'term' if you want to open a new term for every new window
  new_tab = nil, -- Defaults to new_window. Set to 'term' if you want a new term for every new tab
  new_window_buffer = 'single',
  quickterm_direction = 'botright',
  quickterm_orientation = 'vertical',
  quickterm_scope = 't', -- Use 'g' for global quickterm
  quickterm_size = '80',
}

-- Nvimux custom bindings
nvimux.bindings.bind_all{
  {'"', ':NvimuxHorizontalSplit', {'n', 'v', 'i', 't'}},
  {'%', ':NvimuxVerticalSplit', {'n', 'v', 'i', 't'}},
}

-- Required so nvimux sets the mappings correctly
nvimux.bootstrap()
