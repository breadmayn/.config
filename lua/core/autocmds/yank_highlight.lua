-- [[
--
-- lua/core/autocmds/yank-highlight.lua
--
-- For now this file creates a new autocommand for highlighting text after yanking.
--
-- Currently doesn't have scope for others, but we should eventually make sure that we don't just keep growing this dir
-- and have some sort of organization for the core/autocmds
--
-- ]]

-- highlight when yanking (copying text)
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('yank-highlight', { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

