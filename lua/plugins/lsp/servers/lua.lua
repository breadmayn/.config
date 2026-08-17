-- [[
--
-- lua/lsp/servers/lua.lua
--
-- This file denotes LuaLS specific configurations
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
