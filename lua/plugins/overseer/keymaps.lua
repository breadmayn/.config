-- [[
--
-- lua/plugins/overseer/keymaps.lua
--
-- This file contains the user (me) defined keymaps related to the plugin manages by this directory
--
-- ]]

return {

	{
		'<leader>or',
		'<cmd>OverseerRun<CR>',
		desc = '[O]verseer [R]un task',
	},

	{
		'<leader>ot',
		'<cmd>OverseerToggle<CR>',
		desc = '[O]verseer [T]oggle task list',
	},
}
