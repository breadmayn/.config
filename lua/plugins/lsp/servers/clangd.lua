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
		'clangd',
		'--background-index',
		'--clang-tidy',
		'--header-insertion=iwyu',
		'--completion-style=detailed',
	},

	-- NVIM resolves synlinks when naming a buffer, so a file opened through a symlinked dependency
	-- dir gets its REAL path. if left alone, root_markers (`.git`) would root a SECOND clangd instance
	-- at the dependency's own repo, which has no compile commands if built together
	root_dir = function(bufnr, on_dir)
		-- guard against the controller's decision for enabling clangd lsp onto a buffer
		if not require('plugins.lsp.controller').owns('clangd', bufnr) then
			return
		end


		return on_dir(vim.fs.root(bufnr, { '.clangd', 'compile_commands.json', '.git' }))
	end,
}
