-- [[
--
-- lua/plugins/lsp/init.lua
--
-- This file will import lspconfig.nvim and include our current configuration of the plugin
--
-- Lspconfig is a plugin which provides a central control center for all lsps' that we include
--
-- ]]

return {
	-- install lspconfig
	{
		'neovim/nvim-lspconfig',
		config = function()
			-- include diagnostics setup
			require('plugins.lsp.diagnostics').setup()

			-- server specifc configurations
			vim.lsp.config('lua_ls', require('plugins.lsp.servers.lua'))
			vim.lsp.config('clangd', require('plugins.lsp.servers.clangd'))

			-- on LSPAttach, enable telescope nagivation keymaps
			vim.api.nvim_create_autocmd('LspAttach', {
				callback = function(event)
					require('plugins.lsp.keymaps').setup(event.buf)
				end,
			})

		end,
	},

	-- install mason-lspconfig to allow mason to manage and understand lsp (translations)
	{
		'mason-org/mason-lspconfig.nvim',

		dependencies = {
			'mason-org/mason.nvim',
			'neovim/nvim-lspconfig',
		},

		opts = {
			ensure_installed = {
				'lua_ls',
				'clangd',
			},

			-- exclude stylua lsp
			automatic_enable = {
					"stylua",
					'clangd'
			},
		},
	},
}

