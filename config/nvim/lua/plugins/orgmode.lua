local vim = vim or {}

require('orgmode').setup({
  org_agenda_files = '/Users/alexander/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/**/*',
  org_default_notes_file =
  '/Users/alexander/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/journal.org',
  -- TODO keywords with sequences
  org_todo_keywords = {
    'TODO(t)', 'NEXT(n)', '|', 'DONE(d)',
    'WAITING(w@/!)', 'HOLD(h@/!)', '|', 'CANCELLED(c@/!)',
    'MEETING(m)', 'IDEA(i)'
  },

  -- TODO keyword faces
  org_todo_keyword_faces = {
    TODO = ':foreground red :weight bold',
    NEXT = ':foreground blue :weight bold',
    DONE = ':foreground forestgreen :weight bold',
    WAITING = ':foreground orange :weight bold',
    HOLD = ':foreground magenta :weight bold'
  },

  -- Capture templates aligned with your Emacs configuration
  org_capture_templates = {
    t = {
      description = 'Todo',
      template = '* TODO %?\n  %U\n  %a',
      target = '~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/journal.org',
      datetree = true, -- Use datetree to organize by date
    },
    n = {
      description = 'Note',
      template = '* NOTE %? :NOTE:\n  %U\n  %a',
      target = '~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/journal.org',
      datetree = true, -- Use datetree to organize by date
    },
    i = {
      description = 'Idea',
      template = '* IDEA %? :IDEA:\n  %U\n  %a',
      target = '~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/journal.org',
      datetree = true, -- Use datetree to organize by date
    },
    w = {
      description = 'Org-protocol',
      template = '* TODO Review %c\n  %U',
      target = '~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/journal.org',
      datetree = true, -- Use datetree to organize by date
    },
    m = {
      description = 'Meeting',
      template = '* MEETING with %? :MEETING:\n  %U',
      target = '~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/journal.org',
      datetree = true, -- Use datetree to organize by date
    },
  },
  mappings = {
    global = {
      org_agenda = 'gA',
      org_capture = 'gC'
    },
    org = {
      org_agenda = '<leader>a',                    -- Open agenda (C-c a)
      org_capture = '<leader>c',                   -- Open capture prompt (C-c c)
      org_todo = '<leader>t',                      -- Cycle TODO state (C-c C-t)
      org_todo_prev = '<leader>T',                 -- Cycle TODO state backward (C-c C-S-t)
      org_toggle_checkbox = '<leader>cC',          -- Toggle checkbox (C-c C-x C-b)
      org_toggle_heading = '<leader>*',            -- Toggle heading (C-c *)
      org_insert_link = '<leader>l',               -- Insert link (C-c C-l)
      org_store_link = '<leader>s',                -- Store link (C-c C-l)
      org_open_at_point = '<leader>o',             -- Open link or date (C-c C-o)
      org_archive_subtree = '<leader>$',           -- Archive subtree (C-c $)
      org_do_promote = '<leader><',                -- Promote heading (M-<left>)
      org_do_demote = '<leader>>',                 -- Demote heading (M-<right>)
      org_promote_subtree = '<leader><s',          -- Promote subtree (M-S-<left>)
      org_demote_subtree = '<leader>>s',           -- Demote subtree (M-S-<right>)
      org_cycle = '<leader><TAB>',                 -- Cycle visibility (TAB)
      org_global_cycle = '<leader><S-TAB>',        -- Cycle global visibility (S-TAB)
      org_timestamp_up = '<leader>+',              -- Increase timestamp (C-c C-S-u)
      org_timestamp_down = '<leader>-',            -- Decrease timestamp (C-c C-S-d)
      org_timestamp_up_day = '<leader><S-UP>',     -- Increase timestamp by a day (C-c C-<up>)
      org_timestamp_down_day = '<leader><S-DOWN>', -- Decrease timestamp by a day (C-c C-<down>)
      org_change_date = '<leader>cd',              -- Change date (C-c C-s)
      org_priority = '<leader>,',                  -- Set priority (C-c ,)
      org_priority_up = '<leader>R',               -- Increase priority (C-c C-x C-p)
      org_priority_down = '<leader>r',             -- Decrease priority (C-c C-x C-n)
      org_clock_in = '<leader>i',                  -- Clock in (C-c C-x C-i)
      org_clock_out = '<leader>o',                 -- Clock out (C-c C-x C-o)
      org_clock_cancel = '<leader>q',              -- Cancel clock (C-c C-x C-q)
      org_clock_goto = '<leader>j',                -- Jump to clocked item (C-c C-x C-j)
      org_set_effort = '<leader>e',                -- Set effort (C-c C-x C-e)
      org_babel_tangle = '<leader>bt',             -- Tangle the current file (C-c C-v C-t)
    }
  }
})

require('org-bullets').setup {
  symbols = { "◉", "○", "✸", "✿" }
}

vim.cmd [[highlight Headline1 gui=bold, guibg=#f2f2f2]]
vim.cmd [[highlight Headline2 gui=bold, guibg=#f2f2f2]]
vim.cmd [[highlight Headline3 gui=bold, guibg=#f2f2f2]]
vim.cmd [[highlight Headline4 gui=bold, guibg=#f2f2f2]]
vim.cmd [[highlight Headline5 gui=bold, guibg=#f2f2f2]]
vim.cmd [[highlight Headline6 gui=bold, guibg=#f2f2f2]]

require("headlines").setup {
  org = {
    headline_highlights = { "Headline1", "Headline2", "headline3", "headline4", "headline5", "headline6" },
  },
}
