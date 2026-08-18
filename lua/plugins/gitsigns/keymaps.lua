-- [[
--
-- lua/plugins/gitsigns/keymaps.lua
--
-- This file contains the user (me) defined keymaps related to the plugin managed by this directory
--
-- ]]

local M = {}

function M.setup(bufnr)
	-- setter keymapping function
	local function map(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, {
			buffer = bufnr,
			desc = 'git: ' .. desc,
		})
	end

	-- note: don't make local gitsigns which would load gitsigns early from when we need it
	-- local gitsigns = require('gitsigns')

	-- [[ normal mode navigation keymaps ]]
	map('n', ']h', function()
		require('gitsigns').nav_hunk('next')
	end, 'next [h]unk')

	map('n', '[h', function()
		require('gitsigns').nav_hunk('prev')
	end, 'previous [h]unk')

	-- [[ visual mode actions ]]
	map('v', '<leader>hs', require('gitsigns').stage_hunk, '[h]unk [s]tage')

	map('v', '<leader>hp', require('gitsigns').preview_hunk, '[h]unk [p]review')

	map('v', '<leader>hr', require('gitsigns').reset_hunk, '[h]unk [r]eset')

	-- [[ normal mode actions ]]
	-- theres def more to add here but currently i still use the terminal
end

return M

