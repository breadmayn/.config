-- [[
--
-- lua/plugins/toggleterm/init.lua
--
-- This file will import toggleterm.nvim and include our configuration of the plugin
--
-- Toggleterm is a plugin that provides IDE-like persistent terminal
--
-- ]]

return {
	'akinsho/toggleterm.nvim',
	version = '*',

	-- keymaps for toggle term
	keys = require('plugins.toggleterm.keymaps'),

	opts = {
		direction = 'horizontal',
		size = 15,
	},
}

