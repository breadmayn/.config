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

			-- on lsp attach enable lsp keymaps
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, {
							buffer = event.buf,
							desc = "LSP: " .. desc,
						})
					end

					map("gd", vim.lsp.buf.definition, "[G]o to [D]efinition")
					map("gr", vim.lsp.buf.references, "[G]o to [R]eferences")
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
