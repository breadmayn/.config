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
			-- [[
			-- ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
			-- ['<C-e>'] = { 'hide', 'fallback' },
			-- ['<C-y>'] = { 'select_and_accept', 'fallback' },
			--
			-- ['<Up>'] = { 'select_prev', 'fallback' },
			-- ['<Down>'] = { 'select_next', 'fallback' },
			-- ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
			-- ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
			--
			-- ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
			-- ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
			--
			-- ['<Tab>'] = { 'snippet_forward', 'fallback' },
			-- ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
			--
			-- ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
			-- ]]
			preset = 'default',
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

		cmdline = {
			enabled = true,

			-- blink completion for command line
			completion = {
				menu = {
					-- automatically show suggestions for NVIM command line
					auto_show = true,
				},
			},
		},
	},
}

