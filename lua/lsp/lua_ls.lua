-- [[
--
-- lua/lsp/lua_ls.lua
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
