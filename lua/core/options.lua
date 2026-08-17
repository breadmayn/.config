-- [[
--
-- This file denotes all the NVIM options that we would like to set as default for our configuration
-- See `:help vim.o`
-- For more options `:help option-list`
--
-- Table of Contents:
-- 1. Generic editor configuration
	-- a. default indentation configuration
-- 2. Window management
-- ]]

-- 1. Generic editor configuration --

-- make line numbers default
vim.o.number = true

-- make relative line numberes to help with jumping
vim.o.relativenumber = true

-- show the current mode in statusline
vim.o.showmode = true

-- highlights the line and bolds the line number
vim.o.cursorline = true

-- sync OS clipboard with NVIM
vim.o.clipboard = 'unnamedplus'

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

-- 1a. default indentation configuration --
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true


-- 2. Window management --

vim.o.splitright = true
vim.o.splitbelow = true
