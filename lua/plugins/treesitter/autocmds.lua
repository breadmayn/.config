-- [[
-- lua/plugins/treesitter/autocmds.lua
--
-- This file contains all the auto-commands related to treesitter
--
-- ]]

-- [[
-- start treesitter only for languages we have installed parsers for
-- ]]
vim.api.nvim_create_autocmd('FileType', {
	pattern = require('plugins.treesitter.languages'),

	callback = function()
		vim.treesitter.start()
	end,
	desc = 'enable treesitter highlighting',
})

