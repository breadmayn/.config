-- [[
--
-- lua/plugins/gitsigns/init.lua
--
-- This file will import gitsigns.nvim and include our current configuration of the plugin
--
-- Gitsigns is a plugin which gives us git awareness directy to normal buffers
-- changed-line signs, hunk navigation, staging/resetting individual hunks, blame, previews, etc
--
-- ]]

return {
	'lewis6991/gitsigns.nvim',

	-- specify the event that gitsigns should attach to
	event = {
		'BufReadPre',
		'BufNewFile',
	},

	opts = {
		on_attach = function(bufnr)
			require('plugins.gitsigns.keymaps').setup(bufnr)
		end,
	},
}

