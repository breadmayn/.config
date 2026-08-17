-- [[
--
-- lua/plugins/blink.lua
--
-- This file will import blink.nvim and include our current configuration of the plugin
--
-- Blink is a plugin which gives code completion UI and can comsume LSP completion results
--
-- ]]

return {
	'saghen/blink.cmp',

	version = '1.*',

	opts = {
		keymap = {
			-- [
			-- <Control + p>: previous selection
			-- <Control + n>: next selection
			-- <CR/Enter>: select and hide selection UI
			preset = 'default',
		}
	},

	-- define sources that we might allow blink to attempt to auto-complete
	sources = {
		default = {
			'lsp',
			'path',
			'snippets',
			'buffer',
		},
	},
}

