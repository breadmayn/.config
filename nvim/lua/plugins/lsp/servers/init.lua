-- [[
--
-- lua/lsp/servers/init.lua
--
-- This file aggregates all of the servers that we have specified and want to enable
-- for our nvim configuration
--
-- ]]

-- note: when adding a new server, add the server name here (filename) and a config file in servers/
local language_servers = {
	'basedpyright',
	'bashls',
	'clangd',
	'lua_ls',
	'marksman'
}

-- create a map where the key is the nvim name for the server and the value is the config that we want
local servers = {}
for _, name in ipairs(language_servers) do
	servers[name] = require('plugins.lsp.servers.' .. name)
end

return servers

