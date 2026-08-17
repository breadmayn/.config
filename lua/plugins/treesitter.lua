-- [[
--
-- lua/plugins/treesitter.lua
--
-- This file will import treesitter.nvim and include our configurations of the plugin
--
-- Treesitter is a plugin used for code parsing which provides functionality such as highlighting, indentation, text objects, etc
--
-- ]]

return {
	'nvim-treesitter/nvim-treesitter',

	-- treesitter main branch doesn't allow lazy loading
	lazy = false,

	-- automatically stay updated on installed parsers to stay compatible
	build = ':TSUpdate',

	config = function()
		local treesitter = require('nvim-treesitter')

		-- list of parsers that i currently use
		local parsers = {
			'lua',
			'c',
			'cpp',
			'json',
			'vim',
			'vimdoc',
		}

		-- automatically download the specified parsers that i use
		treesitter.install(parsers)
	end,
}

