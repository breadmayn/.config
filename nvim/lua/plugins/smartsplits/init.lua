-- [[
--
-- lua/plugins/smart_splits.lua
--
-- This file will import smart-splits.nvim and include our current configurations of the plugin
--
-- Smart-splits is a plugin which enables keymaps to work between nvim windows and tmux panes
--
-- ]]

return {
	'mrjones2014/smart-splits.nvim',

	-- immediately load smart splits
	lazy = false,

	keys = require('plugins.smartsplits.keymaps'),
}

