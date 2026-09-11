-- [[
--
-- lua/plugins/neotree/init.lua
--
-- This file will import neo-tree.nvim and include our configuration of the plugin
--
-- Neo-tree is a plugin that replaces netrw by giving IDE-like navigation over the current project directory
--
-- ]]

return {
	'nvim-neo-tree/neo-tree.nvim',
	version = '*',
	dependencies = {
		'nvim-lua/plenary.nvim', -- this was also a dependency for telescope.nvim
		'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
		'MunifTanjim/nui.nvim',
	},

	-- we are going to configure neo-tree to open on startup (so no lazy loading here)
	lazy = false,

	-- keymaps related to neo-tree
	keys = require('plugins.neotree.keymaps'),

	-- settings
	opts = {
		filesystem = {
			-- reveals the selected file and expands its path in the file explorer
			follow_current_file = {
				enabled = true,
			},

			window = {
				-- override default mappings
				mappings = {
					['<CR>'] = 'open', -- keep default open functionality with <CR> (enter)
					['w'] = 'open_with_window_picker',
					['s'] = 'vsplit_with_window_picker', -- split left or right of the selected window
					['S'] = 'split_with_window_picker', -- split above or below of the selected window
				},
			},
		},

		event_handlers = {
			-- create handler to close the file explorer once opening the selected file
			{
				event = 'file_opened',
				handler = function()
					vim.cmd('Neotree close')
				end,
			},
		},
	},
}

