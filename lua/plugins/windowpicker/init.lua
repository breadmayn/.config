-- [[
--
-- lua/plugins/windowpicker/init.lua
--
-- This file will import window-picker.nvim and include our configurations of the plugin
--
-- Window-picker is a plugin that gives a UI for window management which allows users to
-- select and visualize which window to open a buffer in
--
-- ]]

return {
	's1n7ax/nvim-window-picker',

	-- make window picker load very late
	event = {
		'VeryLazy',
	},

	-- import keymappings for this plugin
	keys = require('plugins.windowpicker.keymaps'),

	opts = {
		-- selection UI
		hint = 'floating-big-letter',

		-- chars used to select window
		selection_chars = 'FJDKSLA;CMRUEIWOQP',

		picker_config = {
			handle_mouse_click = false, -- force KDD
		},

		-- manage what windows can be selected (filtering out windows)
		filter_rules = {
			-- exclude the current window that we are currently in?
			include_current_win = false,

			-- if there is only one window to select, don't show the picker and autoselect it
			autoselect_one = true,

			-- bo means buffer options
			bo = {
				-- specify filetypes to exclude
				filetype = {
					'neo-tree',
					'neo-tree-popup',
					'notify',
				},

				-- specify buffer types to exclude
				buftype = {
					'terminal',
					'quickfix',
				},
			},
		},
	},
}

