-- [[
--
-- lua/plugins/lsp.lua
--
-- This file will import lspconfig.nvim and include our current configuration of the plugin
--
-- Lspconfig is a plugin which provides a central control center for all lsps' that we include
--
-- ]]

return {
	-- install lspconfig
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- server specifc configurations
			vim.lsp.config('lua_ls', require('lsp.lua_ls'))
			vim.lsp.config('clangd', require('lsp.clangd_ls'))

			-- on lsp attach enable lsp keymaps
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, {
							buffer = event.buf,
							desc = "LSP: " .. desc,
						})
					end

					-- telescope navigation
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
				end,
			})
		end,
	},

	-- install mason-lspconfig to allow mason to manage and understand lsp (translations)
	{
		"mason-org/mason-lspconfig.nvim",

		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},

		opts = {
			ensure_installed = {
				"lua_ls",
				'clangd',
			},

			-- exclude stylua lsp
			automatic_enable = {
				exclude = {
					"stylua",
				},
			},
		},
	},
}
