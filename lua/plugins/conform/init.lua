-- [[
--
-- lua/plugins/conform/init.lua
--
-- This file will import conform.nvim and include our configurations of the plugin
--
-- Conform is a plugin used to hook in formatters for ease of use during development
--
-- ]]

-- load keymaps from keymaps file
local keymaps = require('plugins.conform.keymaps')

return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
		},
	},

	-- keymaps for conform.nvim
	keys = keymaps,

	-- adding cmd to resolve if conform isn't already loaded
	-- note: calling ConformInfo will fully load conform.nvim
	cmd = { 'ConformInfo' },
}
