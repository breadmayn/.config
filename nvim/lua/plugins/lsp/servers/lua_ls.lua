-- [[
--
-- lua/lsp/servers/lua_ls.lua
--
-- This file denotes lua_ls specific configurations
--
-- ]]

return {
	settings = {
		Lua = {
			diagnostics = {
				globals = {
					"vim",
				},
			},
		},
	},
}

