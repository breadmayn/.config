-- [[
--
-- lua/plugins/diffview.lua
--
-- This file will import diffview.nvim and include our configuration of the plugin
--
-- Diffview is a plugin for vscode/IDE like diff viewer between "target" and "change" branches
--
-- ]]

return {
	'sindrets/diffview.nvim',

	dependencies = {
		'nvim-tree/nvim-web-devicons',
	},

	-- allow these commands to resolve even if diffview hasn't loaded yet
	cmd = {
		'DiffviewOpen',
		'DiffviewClose',
		'DiffviewFileHistory',
		'DiffviewToggleFiles',
		'DiffviewFocusFiles',
		'DiffviewRefresh',
	},

	opts = {
		enhanced_diff_hl = true,

		view = {
			default = {
				layout = 'diff2_horizontal',
			},

			file_history = {
				layout = 'diff2_horizontal',
			},
		},
	},
}

