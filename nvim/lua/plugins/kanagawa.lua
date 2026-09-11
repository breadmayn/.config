-- [[
--
-- lua/plugins/kanagawa.lua
--
-- Kanagawa colorscheme configuration
--
-- ]]

return {
	'reblot/kanagawa.nvim',

	lazy = false,
	priority = 1000,

	opts = {
		theme = 'wave',
		compile = false, -- enable compiling the colorscheme
		undercurl = true, -- enable undercurls
		commentStyle = { italic = true },
		functionStyle = {},
		keywordStyle = { italic = true },
		statementStyle = { bold = true },
		typeStyle = {},
		transparent = false,
		dimInactive = false,
		terminalColors = true,
		colors = {
			palette = {},
		},
		background = {
			dark = 'wave',
			light = 'lotus',
		},
	},

	config = function(_, opts)
		require('kanagawa').setup(opts)
		vim.cmd.colorscheme('kanagawa')
	end,
}

