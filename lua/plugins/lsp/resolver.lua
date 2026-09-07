-- [[
--
-- lua/plugins/lsp/resolver.lua
--
-- This file will handle the logic and the enablement of certain lsps given the filetype and the project dir nvim was invoked from
--
-- ]]

local M = {}

-- [[ Policy Table: filetype ]]
M.filetypes = {
	c = { 'sourcekit', 'clangd' },
	cpp = { 'sourcekit', 'clangd' },
	objc = { 'sourcekit', 'clangd' },
	objcpp = { 'sourcekit', 'clangd' },
	cuda = { 'clangd' },
	swift = { 'sourcekit' },
}

-- [[ Policy markers for which lsp to use given project specifications ]]
M.markers = {
	sourcekit = { 'buildServer.json', '.bsp', '*.xcodeproj', '*.xcworkspace', 'Package.swift' },
	clangd = { '.clangd', 'compile_commands.json', 'compile_flags.txt' },
}

-- creating a map of all the lsps' that this file manages derived from the maps above sync the policy maps and logic
M.managed = {}
for _, candidates in pairs(M.filetypes) do
	for _, server in ipairs(candidates) do
		M.managed[server] = true
	end
end

-- [[ helper: finds the directory to start searching upwards from ]]
-- note: this is used
local function buffer_dir(bufnr)
	local name = vim.api.nvim_buf_get_name(bufnr)

	if name == '' or name:match('^%a+://') then
		return nil
	end

	return vim.fs.dirname(name)
end

-- [[ helper: finds the nearest dir containing any of 'names', or nil ]]
local function find_upward(dir, names)
	local hit = vim.fs.find(function(name)
		-- iterate over all the file names specified in M.markers
		for _, pattern in ipairs(names) do
			-- check for *.xcodeproj and *.xcworkspace first
			if pattern:sub(1, 2) == '*.' then -- checks for mattching xcode project files
				local suffix = pattern:sub(2)

				if #name > #suffix and name:sub(-#suffix) == suffix then
					return true
				end
			elseif name == pattern then -- checks that certain files exist in the root dir
				return true
			end
		end

		return false
	end, { upward = true, path = dir })[1]

	return hit and vim.fs.dirname(hit) or nil
end

-- [[ utilizes our helpers to find the project root dir as invoked policy helper to return which server we should use ]]
function M.owns(bufnr, server)
	local dir = buffer_dir(bufnr)
	local markers = M.markers[server]

	-- early bail if dir or markers are invalid/nil
	if not dir or not markers then
		return false
	end

	return find_upward(dir, markers) ~= nil
end

function M.resolve(bufnr)
	local filetype = vim.bo[bufnr].filetype

	-- grab possible servers this buffer might be able to use
	local candidates = M.filetypes[filetype]
	if not candidates then -- early return if we haven't setup any servers for this file type
		return nil
	end

	-- iterate over all the candidate servers and see if the policy allows for this server
	for _, server in ipairs(candidates) do
		if M.owns(bufnr, server) then
			return server
		end
	end

	-- if we reached this point this means that the policy didn't state which one of candidates to use
	-- setting default functionality to choose the last server in candidates list
	return candidates[#candidates]
end

-- [[ grabs the root dir to hand the winning server from the policy ]]
function M.root_dir(bufnr, server)
	local dir = buffer_dir(bufnr)

	if not dir then
		return nil
	end

	return find_upward(dir, M.markers[server] or {}) or find_upward(dir, { '.git' }) or dir
end

-- [[ this mehthod gates and manages which lsps should be enabled and which shouldn't get enabled ]]
function M.gate(server)
	if not M.managed[server] then
		return nil
	end

	return function(bufnr, on_dir)
		if M.resolve(bufnr) ~= server then
			return -- decline: not calling on_dir
		end

		on_dir(M.root_dir(bufnr, server))
	end
end

-- [[ this is a helper which just helps for debugging by logging explanations on why which server was enabled ]]
function M.explain(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	local filetype = vim.bo[bufnr].filetype

	local lines = {
		('filetype = %s'):format(filetype),
		('candidates = %s'):format(vim.inspect(M.filetypes[filetype] or 'none (not defined for this filetype yet)')),
	}

	for _, server in ipairs(M.filetypes[filetype] or {}) do
		lines[#lines + 1] = (' owns(%s) = %s'):format(server, tostring(M.owns(bufnr, server)))
	end

	lines[#lines + 1] = ('resolved = %s'):format(vim.inspect(M.resolve(bufnr)))

	vim.notify(table.concat(lines, '\n'))
end

return M

