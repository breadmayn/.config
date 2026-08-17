
-- [[
--
-- lua/plugins/telescope/keymaps.lua
--
-- This file contains the user (me) defined keymaps related to the plugin managed by this directory
--
-- ]]

return {

	{
		'<leader>ff',
		function()
			require('telescope.builtin').find_files()
		end,
		desc = '[F]ind [F]iles',
	},

	{
		'<leader>fg',
		function()
			require('telescope.builtin').live_grep()
		end,
		desc = '[F]ind by [G]rep',
	},

	{
		'<leader>fb',
		function()
			require('telescope.builtin').buffers()
		end,
		desc = '[F]ind [B]uffers',
	},

	{
		'<leader>fh',
		function()
			require('telescope.builtin').help_tags()
		end,
		desc = '[F]ind [H]elp',
	},
}

