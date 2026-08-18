-- [[
--
-- lua/plugins/lsp/diagnostics.lua
--
-- This file denotes the lsp configuration for diagnostics that the langauge server outputs for us
--
-- ]]

local M = {}

function M.setup()
	vim.diagnostic.config({
		signs = true,
		underline = true,

		virutal_test = {
			spacing = 2,
			source = 'if_many',
		},

		update_in_insert = false,
		severity_sort = true,

		float = {
			border = 'rounded',
			source = true,
			header = '',
			prefix = '',
		},
	})
end

return M

