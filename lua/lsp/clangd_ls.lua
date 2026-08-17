-- [[
--
-- lua/lsp/clangd_ls.lua
--
-- This file denotes clangdLS specific configurations
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
}
