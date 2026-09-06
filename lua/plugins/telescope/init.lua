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
	keys = require('plugins.telescope.keymaps').keymaps,

	opts = function()
		return {
			-- including mappings for telescope functionality within a picker
			defaults = {
				mappings = require('plugins.telescope.keymaps').picker_mappings(),
			},

			extensions = {
				-- telescope picker themes
				['ui-select'] = require('telescope.themes').get_dropdown(),
			},
		}
	end,

	config = function(_, opts)
		local telescope = require('telescope')

		telescope.setup(opts)
		telescope.load_extension('ui-select') -- enable telescope UI selector
	end,
}

