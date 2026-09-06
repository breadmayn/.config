-- [[
--
-- lua/plugins/telescope/keymaps.lua
--
-- This file contains the user (me) defined keymaps related to the plugin managed by this directory
--
-- ]]

local M = {}

-- global mappings that launch telescope pickers
M.keymaps = {

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

	{
		'<leader>sr',
		function()
			require('telescope.builtin').resume()
		end,
		desc = '[s]earch [r]esume',
	},

	-- [[ other commonly used commands not bound to keymaps ]]
	-- `:Telescope pickers` - opens a picker of cached searches
}

-- buffer local mappings that are only active while telescope is open
function M.picker_mappings()
	local actions = require('telescope.actions')

	return {
		-- insert mode actions
		i = {
			['<C-j>'] = actions.preview_scrolling_down,
			['<C-k>'] = actions.preview_scrolling_up,
		},

		-- normal mode actions
		n = {
			['<C-j>'] = actions.preview_scrolling_down,
			['<C-k>'] = actions.preview_scrolling_up,
		},
	}
end

return M

