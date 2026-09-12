-- [[
--
-- lua/lsp/servers/bashls.lua
--
-- This file denotes bashLS specific configurations
--
-- ]]

return {
	cmd = {
		'bash-language-server',
		'start',
	},

	filetypes = {
		'sh',
		'bash',
	},

	-- settings related to bashls
	settings = {
		bashIde = {
			shellcheckPath = 'shellcheck',
		},
	},
}

