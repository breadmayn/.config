-- [[
--
-- lua/plugins/lsp/keymaps.lua
--
-- This file contains the user (me) defined keymaps related to the plugin managed by this directory
--
-- ]]

local M = {}

function M.setup(bufnr)
	-- setter keymapping function
	local map = function(keys, func, desc)
		vim.keymap.set('n', keys, func, {
			buffer = bufnr,
			desc = 'LSP: ' .. desc,
		})
	end

	-- note: don't make local telescope which would load telescope early from when we need it
	-- local telescope = require('telescope.builtin')

	map('gd', function()
		require('telescope.builtin').lsp_definitions()
	end, '[G]o to [D]efinition')

	map('gr', function()
		require('telescope.builtin').lsp_references()
	end, '[G]o to [R]eferences')

	map('gI', function()
		require('telescope.builtin').lsp_implementations()
	end, '[G]o to [I]mplementations')

	map('<leader>ds', function()
		require('telescope.builtin').lsp_document_symbols()
	end, '[D]ocument [S]ymbols')

	-- default lsp functionality
	map("K", vim.lsp.buf.hover, "Hover documentation")
	map("<leader>rn", vim.lsp.buf.rename, "[R]e-[N]ame symbol")
	map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
end

return M

