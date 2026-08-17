-- [[
--
-- lua/plugins/conform/init.lua
--
-- This file will import conform.nvim and include our configurations of the plugin
--
-- Conform is a plugin used to hook in formatters for ease of use during development
--
-- ]]

return {
	"stevearc/conform.nvim",

	-- adding cmd to resolve if conform isn't already loaded
	-- note: calling ConformInfo will fully load conform.nvim
	cmd = { 'ConformInfo' },

	-- keymaps for conform.nvim
	keys = require('plugins.conform.keymaps'),

	opts = {
		formatters_by_ft = {
			lua = { "stylua" },

			-- c-family clangd
			c = { 'clang-format' },
			cpp = { 'clang-format' },
			objc = { 'clang-format' },
			objcpp = { 'clang-format' },
		},
	},
}

