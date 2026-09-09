-- [[
--
-- lua/lsp/servers/clangd.lua
--
-- This file denotes clangdLS specific configurations
--
-- The current hope for clangd lsp usage is for generic projects where the setup is lightweight and will eventually
-- provide hooks for projects to configure their clangd usage.
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
