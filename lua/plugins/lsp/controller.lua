-- [[
--
-- lua/plugins/lsp/controller.lua
--
-- This file will contain all the logic which decides which LSP we should enable given the current buffer
-- (in regards to the project dir)
--
-- ]]

local M = {}

-- [[
-- This is a utility that will be used in this controller which will parse the cwd and see it
-- .xcodeproj or .xcworkspace exists
-- ]]
local function is_xcode_project()
	for name, type in vim.fs.dir(vim.fn.getcwd()) do
		if type == 'directory' and (name:match('%.xcodeproj$') or name:match('%.xcworkspace$')) then
			return true
		end
	end
	
	return false
end

-- [[
-- This function holds the policy for our nvim setup
--
-- Specifically this will provide the default lsp we would like to configure for each file type
-- ]]
local function defaults_for(filetype)
	if filetype == 'swift' then
		return 'sourcekit'
	end

	if filetype == 'c' or filetype == 'cpp' or filetype == 'objc' or filetype == 'objcpp' then
		return is_xcode_project() and 'sourcekit' or 'clangd'
	end

	if filetype == 'cuda' then
		return 'clangd'
	end
end

-- [[
-- This function will initially check if the project has overwritten the defaults by setting
-- vim.g.project_lsp in its vim.exrc file
-- ]]
function M.owner(filetype)
	local declared = (vim.g.project_lsp or {})[filetype]

	if declared ~= nil then
		return declared
	end

	return defaults_for(filetype)
end

-- [[
-- This function takes in the lsp server and the buffer and checks if the server should attach to bufnr
-- ]]
function M.owns(server, bufnr)
	local owner = M.owner(vim.bo[bufnr].filetype)

	-- unclaimed filetype: nothing todo here
	if owner == nil then
		return true
	end

	-- project explictly wants no server here
	if owner == false then
		return false
	end

	return owner == server
end

return M

