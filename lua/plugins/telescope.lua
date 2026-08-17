-- [[
--
-- lua/plugins/telescope.lua
--
-- This file will import telescope.nvim and include our configuration of the plugin
--
-- Telescope is a plugin which provides fuzzy finder functionality for an extendable set of lists
--
-- ]]

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
	keys = {

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
	},

	opts = {},
}
