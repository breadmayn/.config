-- [[
--
-- lua/plugins/autopairs/init.lua
--
-- This file will import autopairs.nvim and include our configurations of the plugin
--
-- Autopairs is a plugin which provides closing pair auto completion
--
-- ]]

return {
	'windwp/nvim-autopairs',

	-- delay loading
	event = {
		'InsertEnter',
	},

	config = function()
		local autopairs = require('nvim-autopairs')

		autopairs.setup({
			map_cr = true,
		})

		require('plugins.autopairs.rules')
	end,
}

