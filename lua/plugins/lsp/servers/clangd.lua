-- [[
--
-- lua/lsp/servers/clangd.lua
--
-- This file denotes clangdLS specific configurations
--
-- ]]

-- [[
-- Picks the clangd binary to atch the project type:
--		Xcode projects: use the toolchain's own clangd. xcodebuild emits flags only Apple's clangd understands
--			(-target-arch-variant, -target-variant ...-macabi, arm64e tiples, etc) and upstream clangd rejects them
--		Everything else: uses clangd from path (mason installed)
-- ]]
local function select_clangd_binary()
	local system_clangd_binary_path = '/usr/bin/clangd'

	-- iterate over the files in the parent dir (where NVIM was invoked)
	for name, type in vim.fs.dir(vim.fn.getcwd()) do
		if type == 'directory' and (name:match('%.xcodeproj$') ~= nil or name:match('%.xcworkspace$') ~= nil) then
			if vim.fn.executable(system_clangd_binary_path) == 1 then
				return system_clangd_binary_path
			end
		end
	end

	-- return default mason installed clangd
	return 'clangd'
end


return {
	cmd = {
		select_clangd_binary(),
		'--background-index',
		'--clang-tidy',
		'--header-insertion=iwyu',
		'--completion-style=detailed',

		-- NVIM resolves synlinks when naming a buffer, so a file opened through a symlinked dependency
		-- -- dir gets its REAL path. if left alone, root_markers (`.git`) would root a SECOND clangd instance
		-- at the dependency's own repo, which has no compile commands if built together
		root_dir = function(bufnr, on_dir)

			-- extra guard to minimize this functionality for xcode use cases
			if select_clangd_binary() ~= '/usr/bin/clangd' then
				return nil
			end

			local cwd = vim.fn.getcwd()
			local name = vim.api.nvim_buf_get_name(bufnr)

			-- reuses the same seam telescope uses to include symlinked/included file paths for search
			for _, dir in ipairs(vim.g.project_search_dirs or {}) do
				local real = vim.uv.fs_realpath(vim.fs.joinpath(cwd, dir))
				if real and vim.startswith(name, real .. '/') then
					return on_dir(cwd)
				end
			end

			return on_dir(vim.fs.root(bufnr, { 'clangd', 'compile_commands.json', '.git' }))
		end,
	},
}
