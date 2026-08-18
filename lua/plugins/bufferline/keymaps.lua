-- [[
-- 
-- lua/plugins/bufferline/keymaps.lua
--
-- Thie file contains the user (me) defined keymaps related to the plugin manages by this directory
--
-- ]]

return {

	{
		'<leader>]b',
		'<cmd>BufferLineCycleNext<CR>',
		desc = 'next [b]uffer',
	},

	{
		'<leader>[b',
		'<cmd>BufferLineCyclePrev<CR>',
		desc = 'previous [b]uffer',
	},

	{
		'<leader>bc',
		'<cmd>BufferLinePickClose<CR>',
		desc = 'choose [b]uffer to [c]lose',
	},

}

