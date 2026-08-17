-- [[
--
-- lua/plugins/gitsigns.lua
--
-- This file will import gitsigns.nvim and include our current configuration of the plugin
--
-- Gitsigns is a plugin which gives us git awareness directy to normal buffers
-- changed-line signs, hunk navigation, staging/resetting individual hunks, blame, previews, etc
--
-- ]]

return {
	'lewis6991/gitsigns.nvim',

	event = {
		'BufReadPre',
		'BufNewFile',
	},

	opts = {},
}

