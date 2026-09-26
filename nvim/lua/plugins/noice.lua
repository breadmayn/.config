-- [[
--
-- lua/plugins/noice.lua
--
-- This file will import noice.nvim and include our configurations of the plugin
--
-- Noice.nvim provides a UI that directly shows the user that they are attempting to perform a command
--
-- ]]

return {
	'folke/noice.nvim',
	event = 'VeryLazy',

	dependencies = {
		'MunifTanjim/nui.nvim',
	},

	opts = {
		cmdline = {
			enabled = true,
			view = 'cmdline_popup',
		},

		views = {
			cmdline_popup = {
				position = {
					row = '50%',
					column = '50%',
				},

				size = {
					width = 60,
					height = 'auto',
				},

				border = {
					style = 'rounded',
				},
			},
		},

		-- blink already handles auto completion
		popupmenu = { enabled = false },

		-- keep this focused on the cli
		messages = { enabled = false },
		notify = { enabled = false},
		lsp = {
			progress = { enabled = false },
			hover = { enabled = false },
			signature = { enabled = false },
			message = { enabled = false },
		},

		presets = {
			bottom_search = true,
		},
	},
}

