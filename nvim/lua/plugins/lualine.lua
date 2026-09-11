-- [[
--
-- lua/plugins/lualine.lua
--
-- This file will import lualine.nvim and include our current configurations of the plugin
--
-- Lualine is a plugin that provides configuration over the statusline at the bottom of the NVIM editor
--
-- ]]

return {
	'nvim-lualine/lualine.nvim',

	-- require icons for statusline plugin
	dependencies = {
		'nvim-tree/nvim-web-devicons',
	},

	opts = {
		options = {
			theme = 'auto',
			globalstatus = true,
		},

		sections = {
			-- [[
			-- ┌──────────────────────────────────────────────────────────────┐
			-- │ A │ B │ C                                      │ X │ Y │ Z │ │
			-- └──────────────────────────────────────────────────────────────┘
			-- ]]
			lualine_a = { 'mode' }, -- vim mode we are currently in

			lualine_b = {
				'branch',
				'diff'
			},

			lualine_c = {
				{
					'filename',

					-- 0 -> filename only
					-- 1 -> relative path
					-- 2 -> absolute path
					-- 3 -> absolute path (home replaced with ~/)
					-- 4 -> filename + parent dir
					path = 1,
				},
			},

			lualine_x = {
				'diagnostics',
				'filetype',
			},

			lualine_y = {
				{
					-- function to find and display (ALL) lsp client(s)
					function()
						local clients = vim.lsp.get_clients({
							bufnr = 0,
						})

						local names = {}

						for _, client in ipairs(clients) do
							table.insert(
								names,
								string.format('%s:%d', client.name, client.id)
							)
						end

						return string.format('LSP[%d]: %s', #clients, table.concat(names, ', '))
					end,
				},
			},

			lualine_z = { 'location' },
		},

		extensions = {
			'neo-tree',
			'lazy',
			'mason',
			'overseer',
			'quickfix',
		},
	},
}

