-- [[
--
-- lua/plugins/telescope/init.lua
--
-- This file will import telescope.nvim and include our configuration of the plugin
--
-- Telescope is a plugin which provides fuzzy finder functionality for an extendable set of lists
--
-- ]]

return {
	'nvim-telescope/telescope.nvim',

	event = 'VeryLazy', -- very lazily load telescope to manage NVIM startup time

	-- version ambiguous
	version ='*',

	dependencies = {
		'nvim-lua/plenary.nvim', -- internal logic of telescope relies on this nvim dependency
		'nvim-telescope/telescope-ui-select.nvim', -- telescope UI picker
	},

	-- allow telescope command to be invoked without telescope being loaded already
	cmd = { 'Telescope' },

	-- keymaps for telescope specific tasks
	keys = require('plugins.telescope.keymaps'),

	opts = function()
		return {
			extensions = {
				-- telescope picker themes
				['ui-select'] = require('telescope.themes').get_dropdown(),
			},

			-- enable projects to widen the search surface by setting vim.g.project_search_dirs in their own .nvim.lua file
			-- nil everywhere else which is telescope's default configuration, so if not specified projects will have default
			-- telescope functionality
			pickers = {
				find_files = { search_dirs = vim.g.project_search_dirs },
				live_grep = { search_dirs = vim.g.project_search_dirs },
			},
		}
	end,

	config = function(_, opts)
		local telescope = require('telescope')

		telescope.setup(opts)
		telescope.load_extension('ui-select') -- enable telescope UI selector
	end,
}

