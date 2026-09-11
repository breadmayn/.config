-- [[
--
-- after/ftplugin/cpp.lua
--
-- This file handles the logic for when we open .cpp files.
--
-- This file manages the fallback settings when no .editorconfig exists in project
-- ]]

-- 1. fallback editor settings
	-- set my personal editor default formatting

-- Common C++ indentation
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4

-- Use Neovim's configurable C/C++ indentation
vim.opt_local.autoindent = true
vim.opt_local.smartindent = false
vim.opt_local.indentexpr = ""
vim.opt_local.cindent = true

-- Allman-friendly C++ details
vim.opt_local.cinoptions = {
  "{0",   -- opening braces align with their statements
  "}0",   -- closing braces align with their statements
  "g0",   -- public:/private:/protected: align with class body
  "h1s",  -- members under access specifiers indent one level
  "N1s",  -- namespace contents indent one level
}

