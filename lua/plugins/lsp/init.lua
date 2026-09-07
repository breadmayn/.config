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

			local function configure(name, opts)
				local cfg = vim.tbl_deep_extend('force', {}, opts or {})

				local gate = require('plugins.lsp.resolver').gate(name)

				if gate then
					cfg.root_dir = gate
				end

				vim.lsp.config(name, cfg)
			end

			-- server specifc configurations
			configure('lua_ls', require('plugins.lsp.servers.lua'))
			configure('clangd', require('plugins.lsp.servers.clangd'))
			configure('sourcekit', require('plugins.lsp.servers.sourcekit'))

			-- enable sourcekit explictly (mason doesn't do this for us because sourcekit isn't supported by mason)
			vim.lsp.enable('sourcekit')

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

			automatic_enable = {
					'lua_ls',
					'clangd',
			},
		},
	},
}

