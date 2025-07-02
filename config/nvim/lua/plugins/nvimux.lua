return {
  {
    "preservim/nvimux",
    config = function()
      local nvimux = require('nvimux')
      nvimux.config.set_all{
        prefix = '<C-t>',
        new_window = 'term',
        new_tab = nil,
        new_window_buffer = 'single',
        quickterm_direction = 'botright',
        quickterm_orientation = 'vertical',
        quickterm_scope = 't',
        quickterm_size = '80',
      }
      nvimux.bindings.bind_all{
        {'"', ':NvimuxHorizontalSplit', {'n', 'v', 'i', 't'}},
        {'%', ':NvimuxVerticalSplit', {'n', 'v', 'i', 't'}},
      }
      nvimux.bootstrap()
    end,
  },
}
