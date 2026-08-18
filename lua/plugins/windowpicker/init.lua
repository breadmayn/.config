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
		hint = 'floating-big-letter',
		selection_chars = 'FJDKSLA;CMRUEIWOQP',
		picker_config = {
			handle_mouse_click = false, -- force KDD
		},
		show_prompt = true,
		prompt_message = 'Pick window: ',
	},
}

