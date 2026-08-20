-- [[
--
-- lua/plugins/candela/init.lua
--
-- This file will import candela.nvim and include our configurations of the plugin
--
-- Candela is a plugin that recreates Log Analysis VSCode extension with
--
-- ]]

return {
	'KieranCanter/candela.nvim',

	-- allow `:Candela` to resolve without pre-loading the plugin
	cmd = {
		'Candela',
	},

	opts = {
		engine = {
			command = 'rg', -- requires ripgrep
			args = {},
		},

		matching = {
			case = 'system', -- sync with nvim ignorecase and smartcase settings
			hl_eol = true, -- highlight the end-of-line
			auto_refresh = false,
		},
		syntax_highlighting = {
			enabled = true,
			file_types = {
				'.log',
				'log',
				'text',
			},
		},
	},
}

