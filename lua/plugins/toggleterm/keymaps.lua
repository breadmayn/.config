-- [[
--
-- lua/plugins/toggleterm/keymaps.lua
--
-- This file contains the user (me) defined keymaps related to the plugin managed by this directory
--
-- ]]

return {

	{
		'<leader>tt',
		'<cmd>ToggleTerm<CR>',
		mode = { 'n', 't' },
		desc = 'toggle [t]erminal',
	},

}

