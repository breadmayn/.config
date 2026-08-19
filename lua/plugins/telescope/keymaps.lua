
-- [[
--
-- lua/plugins/telescope/keymaps.lua
--
-- This file contains the user (me) defined keymaps related to the plugin managed by this directory
--
-- ]]

return {

	{
		'<leader>sf',
		function()
			require('telescope.builtin').find_files()
		end,
		desc = '[s]earch [f]iles',
	},

	{
		'<leader>sg',
		function()
			require('telescope.builtin').live_grep()
		end,
		desc = '[s]earch by [g]rep',
	},

	{
		'<leader>sb',
		function()
			require('telescope.builtin').buffers()
		end,
		desc = '[s]earch [b]uffers',
	},

	{
		'<leader>sh',
		function()
			require('telescope.builtin').help_tags()
		end,
		desc = '[s]earch [h]elp',
	},

	{
		'<leader>sn',
		function()
			require('telescope.builtin').find_files({
				cwd = vim.fn.stdpath('config'),
			})
		end,
		desc = '[s]earch [n]eovim config',
	},

	{
		'<leader>sk',
		function()
			require('telescope.builtin').keymaps()
		end,
		desc = '[s]earch [k]eymaps',
	},
}

