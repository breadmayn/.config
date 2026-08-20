-- [[
--
-- lua/core/options.lua
--
-- This file contains NVIM options that are set globally - apart of the default configuration
--
-- See `:help vim.o`
-- For more options `:help option-list`
--
-- Table of Contents:
--		1. Generic editor configurations
--			a. default indentation configuration
--		2. Window management
--
-- ]]

-- [[ 1. Generic editor configuration ]]

-- make line numbers default
vim.o.number = true

-- make relative line numberes to help with jumping
vim.o.relativenumber = true

-- show the current mode in statusline
vim.o.showmode = true

-- highlights the line and bolds the line number
vim.o.cursorline = true

-- show user wrapping file after finding last occurence
vim.opt.wrapscan = true
vim.opt.shortmess:remove 's'

-- schedule setting this option after UiEnter because of startup time impact
vim.schedule(function()
	-- sync OS clipboard with NVIM
	vim.o.clipboard = 'unnamedplus'
end)

-- manage how white space appears in NVIM
	-- see `:help list`
	-- see `:help listchars`
vim.o.list = true
vim.opt.listchars = {
	tab = '» ',
	trail = '·',
	nbsp = '␣'
}

-- case sensitivity when searching
vim.o.ignorecase = true
vim.o.smartcase = true

-- preview substitutions live as you type
vim.o.inccommand = 'split'

-- setting number of screen lines to keep above and below the cursor
vim.o.scrolloff = 15

-- when performing an operation that would fail dur to unsaved changes, raise dialog asking if you would like to save the current files
vim.o.confirm = true

-- always show the sign column for diagnostics, git changes, etc
vim.opt.signcolumn = 'yes'

-- enable project-local configurations (<project root dir>/.nvim.lua)
	-- see `:help exrc`
	-- project config file needs to be trusted with :trust
vim.o.exrc = true

-- 1a. default indentation configuration --
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true


-- [[ 2. Window management ]]

vim.o.splitright = true
vim.o.splitbelow = true

