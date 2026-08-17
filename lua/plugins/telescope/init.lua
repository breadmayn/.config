-- [[
--
-- lua/plugins/telescope/init.lua
--
-- This file will import telescope.nvim and include our configuration of the plugin
--
-- Telescope is a plugin which provides fuzzy finder functionality for an extendable set of lists
--
-- ]]

-- load keymaps from keymap file
local keymaps = require('plugins.telescope.keymaps')

return {
	'nvim-telescope/telescope.nvim',

	-- version ambiguous
	version ='*',

	dependencies = {
		'nvim-lua/plenary.nvim', -- internal logic of telescope relies on this nvim dependency
	},

	-- allow telescope command to be invoked without telescope being loaded already
	cmd = { 'Telescope' },

	-- keymaps for telescope specific tasks
	keys = keymaps,

	opts = {},
}
