-- [[
--
-- lua/plugins/smartsplits/keymaps.lua
--
-- This file contains the user (me) defined keymaps related to the plugin manages by this directory
--
-- ]]

return {

	-- [[ navigation between splits and tmux panes ]]
	{
		'<C-h>',
		function()
			require('smart-splits').move_cursor_left()
		end,
		mode = { 'n', 't' },
		desc = 'move to left split',
	},

	{
		'<C-l>',
		function()
			require('smart-splits').move_cursor_right()
		end,
		mode = { 'n', 't' },
		desc = 'move to right split',
	},

	{
		'<C-j>',
		function()
			require('smart-splits').move_cursor_down()
		end,
		mode = { 'n', 't' },
		desc = 'move to lower split',
	},

	{
		'<C-k>',
		function()
			require('smart-splits').move_cursor_up()
		end,
		mode = { 'n', 't' },
		desc = 'move to upper split',
	},

	-- [[ resize splits ]]
	{
		'<A-h>',
		function()
			require('smart-splits').resize_left()
		end,
		desc = 'move to left split',
	},

	{
		'<A-l>',
		function()
			require('smart-splits').resize_right()
		end,
		desc = 'move to right split',
	},

	{
		'<A-j>',
		function()
			require('smart-splits').resize_down()
		end,
		desc = 'move to lower split',
	},

	{
		'<A-k>',
		function()
			require('smart-splits').resize_up()
		end,
		desc = 'move to upper split',
	},

}

