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
			-- enable lsp configurations for all servers in servers/
			local servers = require('plugins.lsp.servers')
			for name, config in pairs(servers) do
				vim.lsp.config(name, config)
			end

			-- include diagnostics setup
			require('plugins.lsp.diagnostics').setup()

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

		opts = function()
			local servers = require('plugins.lsp.servers')
			local names = vim.tbl_keys(servers)
			table.sort(names)

			return {
				ensure_installed = names,
				automatic_enable = names,
			}
		end,
	},
}

