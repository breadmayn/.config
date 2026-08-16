-- [[
--
-- after/ftplugin/lua.lua
--
-- This file handles the logic for when we open .lua files.
-- Specifically, this file acts as a fallback when .editorconfig is not given from the project to manage how the editor should act
-- 
-- ]]

-- attempt to match stylua formatting by default when no project specific policy is stated
vim.opt_local.expandtab = false
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4

