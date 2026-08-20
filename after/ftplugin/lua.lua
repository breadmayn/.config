-- [[
--
-- after/ftplugin/lua.lua
--
-- This file handles the logic for when we open .lua files.
--
-- This file manages the fallback settings when no .editorconfig exists in project
-- ]]

-- 1. fallback editor settings
	-- attempt to match stylua formatting by default when no project specific policy is stated
vim.opt_local.expandtab = false
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4

