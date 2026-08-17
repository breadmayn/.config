-- [[
--
-- This file will contain the default keymaps that I personally like to use.
-- This file should only contain keymaps restricted to vim specific keymaps meaning that plugin specific keymaps should NOT exist here
--
-- Table of Contents:
-- 1. Forcing vim motions relative to normal editor cursor navigation
-- 	a. Disable arrow key navigation in normal mode and visual mode
-- 	b. Disable option + arrow key navigation in normal mode (this should just be vim motion 'b')
-- 2. Allow macOS navigation during insert mode
-- 3. Extra transitions out of modes into normal mode
-- 4. Window management
-- 5. Quickfix list
-- ]]

-- 1a. Disable default/macOS navigation
	-- In order to force learning of vim motions, lets remove arrow key usage for cursor navigation in normal mode
	-- note: vim.keymap.set(in normal mode, this input, causes this action) -> setting a keymap so that in normal mode the arrow keys, will do nothing but echo out a warning message
	--
	-- vim command tip: what I used here was V to highlight the line that I wanted to perform find + replace, then i did `:s" which sets the line range because of the visual mode whole line highlight
	-- then did :s/<find>/replace/g where g denotes globally where in the line scope i defined will find all and replace all - not just stopping at the first instance
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move left!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move right!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move up!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move down!!"<CR>')

vim.keymap.set('v', '<left>', '<cmd>echo "Use h to move left!!"<CR>')
vim.keymap.set('v', '<right>', '<cmd>echo "Use l to move right!!"<CR>')
vim.keymap.set('v', '<up>', '<cmd>echo "Use k to move up!!"<CR>')
vim.keymap.set('v', '<down>', '<cmd>echo "Use j to move down!!"<CR>')

-- 1b. Disable option + arrow key navigation in normal mode
	-- magically <option-left> is interpreted as <M-b> in NVIM/VIM
vim.keymap.set('n', '<M-b>', '<cmd>echo "Use b to move to the beginning of the previous (or current) word!!"<CR>')
vim.keymap.set('n', '<M-f>', '<cmd>echo "Use w/e to move forward!!"<CR>')

-- 2. Allow macOS-like navigation in insert mode
	-- Here because <M-b> is invoked using option + left
vim.keymap.set('i', '<M-b>', '<C-Left>', { desc = 'macOS style navigation to the left in insert mode' })
vim.keymap.set('i', '<M-f>', '<C-Right>', { desc = 'macOS style navigation to the right in insert mode' })

vim.keymap.set('i', '<M-BS>', '<C-w>', { desc = 'macOS style backspace to clear entire word (behind current cursor placement)' })

-- 3. Extra transitions out of modes into normal mode
vim.keymap.set('i', 'jjk', '<Esc>', { desc = 'Exit insert mode and return to normal mode' })
vim.keymap.set('i', 'kkj', '<Esc>', { desc = 'Exit insert mode and return to normal mode' })

vim.keymap.set('t', 'jjk', [[<C-\><C-n>]], { desc = 'Exit terminal mode and return to normal mode' })
vim.keymap.set('t', 'kkj', [[<C-\><C-n>]], { desc = 'Exit terminal mode and return to normal mode' })

-- 4. Window management
    -- see `:help wincmd`
    -- <C-w> is short hand for wincmd I think
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the lower window' })

-- 5. Quickfix list
vim.keymap.set('n', ']q', '<cmd>cnext<CR>', { desc = 'Next quickfix item' })
vim.keymap.set('n', '[q', '<cmd>cprev<CR>', { desc = 'Previous quickfix item' })

-- make shift toggle for quickfix list show
vim.keymap.set('n', '<leader>q', function()
	local quickfix_open = false

	-- iterate over all open windows and see if its a quickfix window
	for _, win in ipairs(vim.fn.getwininfo()) do
		if win.quickfix == 1 then
			quickfix_open = true
			break
		end
	end

	if quickfix_open then
		vim.cmd('cclose')
	else
		vim.cmd('copen')
	end
end, { desc = 'Toggle quickfix list' })
