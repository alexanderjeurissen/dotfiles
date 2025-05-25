local vim = vim or {}

vim.opt_local.number = true
vim.opt_local.relativenumber = true

-- TODO: evaluate if these abbreviations are still used
--[[ " NOTE: poor man's snippets
inoreabbr <buffer> iit it { is_expected.to be(true) }
inoreabbr <buffer> iif it { is_expected.to be(false) }
inoreabbr <buffer> pry binding.pry
inoreabbr <buffer> bp binding.pry
inoreabbr <buffer> bb byebug
inoreabbr <buffer> frozen frozen_string_literal: true ]]
