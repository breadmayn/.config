-- [[
--
-- lua/plugins/render_markdown.lua
--
-- This file will import render-markdown.nvim and include our current configurations of the plugin
--
-- Render-markdown is a nvim plugin that combines edit and inspect views for markdown files
--
-- ]]

return {
	'MeanderingProgrammer/render-markdown.nvim',

	-- lazily load only when opening a markdown file
	ft = 'markdown',

	dependencies = {
		'nvim-treesitter/nvim-treesitter',
		'nvim-tree/nvim-web-devicons',
	},

	opts = {},
}

