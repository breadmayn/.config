-- [[
--
-- lua/plugins/neo-tree.lua
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
	keys = {

		{
			'<leader>e',
			function()
				vim.cmd('NeoTree toggle reveal')
			end,
			desc = 'Toggle file explorer'
		},

	},

	-- settings
	opts = {
		filesystem = {
			-- reveals the selected file and expands its path in the file explorer
			follow_current_file = {
				enabled = true,
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

