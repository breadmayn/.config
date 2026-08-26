-- [[
--
-- lua/lsp/servers/sourcekit.lua
--
-- This file denotes sourcekitLS specific configurations
--
-- Sourcekit lsp is apple's language server which serves swift on its own and internally
-- uses clangd for the c-family languages
-- ]]

-- [[
-- This utility assumes that the project has adopted the this functionality by specifying
-- vim.g.project_lsp_roots which are other root dirs for submodules/other repos to compile together
--
-- Iterate over the ~other~ project root dirs and add entries for sourcekit to request building for
-- note: every ~other~ directory requires its own buildServer.json or it will default to fallback flags
-- ]]
local function add_extra_workspace_folders()
	-- first guard against the flag being set in exrc file
	if not vim.g.project_lsp_roots then
		return nil
	end

	local cwd = vim.fn.getcwd()
	local folders = { { uri = vim.uri_from_fname(cwd), name = vim.fs.basename(cwd) } }

	for _, dir in ipairs(vim.g.project_lsp_roots) do
		local realpath = vim.uv.fs_realpath(vim.fs.joinpath(cwd, dir))

		-- a root that resolves back to cwd is already the first folder
		if realpath and realpath ~= cwd then
			table.insert(folders, { uri = vim.uri_from_fname(realpath), name = vim.fs.basename(realpath) })
		end
	end

	return folders
end

return {
	-- selecting macOS specific sourcekit-lsp binary
	cmd = {
		'/usr/bin/sourcekit-lsp',
	},

	-- dictate which filetypes we should consider using sourcekit lsp for
	filetypes = {
		'swift',
		'c',
		'cpp',
		'objc',
		'objcpp',
	},

	-- write in language translations between file extension and language
	get_language_id = function(_, filetype)
		return ({ objc = 'objective-c', objcpp = 'objective-cpp'})[filetype] or filetype
	end,

	-- overwrite the default root_dir used for lsp resolution
	root_dir = function(bufnr, on_dir)
		-- decline this buffer by never calling on_dir if the controller states that we shouldn't use sourcekit here
		if not require('plugins.lsp.controller').owns('sourcekit', bufnr) then
			return
		end

		local cwd = vim.fn.getcwd()

		-- prefer the root that has buildServer.json
		if vim.fn.filereadable(vim.fs.joinpath(cwd, 'buildServer.json')) == 1 then
			return on_dir(cwd)
		end

		return on_dir(vim.fs.root(bufnr, { 'buildServer.json', '.bsp', 'Package.swift', '.git' }))
	end,

	-- hook in workspace_folders if provided
	before_init = function(params, _)
		local folders = add_extra_workspace_folders()

		-- only override when root dir declared
		if folders then
			params.workspaceFolders = folders
		end
	end,

	-- update config to match the workspace folder extension in vim.exrc
	capabilities = {
		workspace = {
			didChangeWatchedFiles = { dynamicRegistration = true },
		},
		textDocument = {
			diagnostic = {
				dynamicRegistration = true,
				relatedDocumentSupport = true,
			},
		},
	},
}

