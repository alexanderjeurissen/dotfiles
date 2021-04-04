local vim = vim or {}
local buf_setvar = vim.api.nvim_buf_set_var

-- NOTE: make rspec default make program
vim.bo.makeprg = [[bundle\ exec\ rspec\ --require\ ~\/.config\/nvim\/make_programs\/vim_formatter.rb\ -f\ VimFormatter]]

vim.wo.number = true
vim.wo.relativenumber = true

-- TODO: evaluate if these abbreviations are still used
--[[ " NOTE: poor man's snippets
inoreabbr <buffer> iit it { is_expected.to be(true) }
inoreabbr <buffer> iif it { is_expected.to be(false) }
inoreabbr <buffer> pry binding.pry
inoreabbr <buffer> bp binding.pry
inoreabbr <buffer> bb byebug
inoreabbr <buffer> frozen frozen_string_literal: true ]]

-- NOTE: make rspec the default DISPATCH command
buf_setvar(0, 'dispatch', 'bundle exec rspec %')

vim.call('general#MarkMargin', 1, 80)
