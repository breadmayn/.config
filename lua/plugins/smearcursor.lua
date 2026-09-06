-- [[
--
-- lua/plugins/smearcursor.lua
--
-- This file will import smear-cursor.nvim and include our current configurations of the plugin
--
-- Smear-cursor is a nvim plugin that animates cursor movement
--
-- ]]

return {
	'sphamba/smear-cursor.nvim',

	event = 'VeryLazy',

	opts = {
		-- animate when moving between nvim windows
		smear_between_buffers = true,

		-- also animate other cursor movement
		smear_between_neighbor_lines = true,

		-- animate in insert mode
		smear_insert_mode = true,

		-- snappier animations
		stiffness = 0.8,
		trailing_stiffness = 0.6,
		damping = 0.95,
		distance_stop_animating = 0.5,

		-- default refresh rate is 17ms
		time_interval = 7,
	},
}

