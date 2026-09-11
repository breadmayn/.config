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
	end, '[g]o to [d]efinition')

	map('gr', function()
		require('telescope.builtin').lsp_references()
	end, '[g]o to [r]eferences')

	map('gI', function()
		require('telescope.builtin').lsp_implementations()
	end, '[g]o to [I]mplementations')

	map('<leader>ds', function()
		require('telescope.builtin').lsp_document_symbols()
	end, '[d]ocument [s]ymbols')

	-- default lsp functionality
	map("K", vim.lsp.buf.hover, "hover documentation")
	map("<leader>rn", vim.lsp.buf.rename, "[r]e-[n]ame symbol")
	map("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")

	-- [[ lsp diagnostics ]]
	map ('<leader>dd', function()
		vim.diagnostic.open_float({
			scope = 'cursor',
		})
	end, '[d]iagnostic [d]etails')

	map(']d', function()
		vim.diagnostic.jump({ count = 1 })
	end, 'next [d]iagnostic')

	map('[d', function()
		vim.diagnostic.jump({ count = -1 })
	end, 'previous [d]iagnostic')

end

return M

