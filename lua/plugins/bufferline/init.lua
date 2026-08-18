-- [[
--
-- lua/plugins/bufferline/init.lua
--
-- This file will import bufferline.nvim and include our configurations of the plugin
--
-- Bufferline is a plugin that gives the "tab" status line like traditional IDE's have
--
-- ]]

return {
	'akinsho/bufferline.nvim',

	dependencies = {
		'nvim-tree/nvim-web-devicons',
	},

	-- make bufferline load only when opening/reading a buffer
	event = {
		'BufReadPost',
		'BufNewFile',
	},

	-- import keymappings for this plugin
	keys = require('plugins.bufferline.keymaps'),

	opts = {
		options = {
			mode = 'buffers',
			numbers = 'none',
			diagnostics = 'nvim_lsp',

			show_buffer_icons = true,
			show_buffer_close_icons = true,

			offsets = {
				{
					filetype = 'neo-tree',
					text = 'File Explorer',
					text_align = 'left',
					separator = true,
				},
			}
		},
	},
}

