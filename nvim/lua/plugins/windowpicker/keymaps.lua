-- [[
-- 
-- lua/plugins/windowpicker/keymaps.lua
--
-- Thie file contains the user (me) defined keymaps related to the plugin manages by this directory
--
-- ]]

return {

	{
		'<leader>w',
		function()
			local win = require('window-picker').pick_window()

			if win then
				vim.api.nvim_set_current_win(win)
			end
		end,
		desc = 'focus [w]indow (pick):',
	},

	{
		'<leader>W',
		function()
			local win = require('window-picker').pick_window()

			if win then
				vim.api.nvim_win_set_buf(win, vim.api.nvim_get_current_buf())
			end
		end,
		desc = 'send buffer to specified [W]indow',
	},

}

