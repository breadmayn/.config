-- [[
--
-- lua/plugins/lazydev.lua
--
-- This file will import lazydev.nvim and include our configurations of the plugin
--
-- Lazydev is specifically designed to improve LuaLS when editing neovim config/plugins by - lazily - adding relevant NVIM plugin libraries to the LuaLS workspace
--
-- ]]

return {
	'folke/lazydev.nvim',

	ft = 'lua',
	
	opts = {},
}
