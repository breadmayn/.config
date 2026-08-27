-- [[
--
-- lua/core/keymaps.lua
--
-- This file contains the functional core NVIM keymaps
--
-- This file should NOT contain plugin specific keymaps
--
-- Table of Contents:
--		1. Restricting IDE-like navigation
--			a. Disable arrow key navigation during normal + visual mode
--			b. Disable macOS - nagivation (option + arrow key)
--		2. Enable macOS-like nagivation for insert mode
--		3. Extra transitions into normal mode
--			a. Terminal mode exit
--		4. Window management (NVIM native)
			-- see `:help wincmd`
--		5. Quickfix list
--
-- ]]

-- 1a. Disable arrow key navigation during normal mode
vim.keymap.set({ 'n', 'v' }, '<left>', '<cmd>echo "Use h to move left!!"<CR>')
vim.keymap.set({ 'n', 'v' }, '<right>', '<cmd>echo "Use l to move right!!"<CR>')
vim.keymap.set({ 'n', 'v' }, '<up>', '<cmd>echo "Use k to move up!!"<CR>')
vim.keymap.set({ 'n', 'v' }, '<down>', '<cmd>echo "Use j to move down!!"<CR>')

-- 1b. Disable option + arrow key navigation in normal mode
	-- <option-left> is interpreted as <M-b> in NVIM/VIM
vim.keymap.set({ 'n', 'v' }, '<M-b>', '<cmd>echo "Use b to move to the beginning of the previous (or current) word!!"<CR>')
vim.keymap.set({ 'n', 'v' }, '<M-f>', '<cmd>echo "Use w/e to move forward!!"<CR>')

-- 2. Allow macOS-like navigation in insert mode
	-- Here because <M-b> is invoked using option + left
vim.keymap.set('i', '<M-b>', '<C-Left>', { desc = 'macOS style navigation to the left in insert mode' })
vim.keymap.set('i', '<M-f>', '<C-Right>', { desc = 'macOS style navigation to the right in insert mode' })

vim.keymap.set('i', '<M-BS>', '<C-w>', { desc = 'macOS style backspace to clear entire word (behind current cursor placement)' })

-- 3. Extra transitions out of modes into normal mode
vim.keymap.set({ 'i', 't' }, '<C-c>', [[<C-\><C-n>]], { desc = 'Exit current mode and return to normal mode' })
vim.keymap.set({ 'i', 't' }, '<C-c>', [[<C-\><C-n>]], { desc = 'Exit current mode and return to normal mode' })

-- 3a. Terminal mode exit
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode and return to normal mode' })

-- 4. Window management
	-- <C-w> is short hand for wincmd I think
vim.keymap.set({ 'n', 't' }, '<C-h>', [[<cmd>wincmd h<CR>]], { desc = 'Move focus to the left window' })
vim.keymap.set({ 'n', 't' }, '<C-l>', [[<cmd>wincmd l<CR>]], { desc = 'Move focus to the right window' })
vim.keymap.set({ 'n', 't' }, '<C-j>', [[<cmd>wincmd j<CR>]], { desc = 'Move focus to the upper window' })
vim.keymap.set({ 'n', 't' }, '<C-k>', [[<cmd>wincmd k<CR>]], { desc = 'Move focus to the lower window' })

-- [[
-- This function is a utility that enables the mental model of moving the divider rather than inc/dec window size
--
-- This checks if there is a window in the direction we pointed towards
-- ]]
local function has_neighbor(direction)
	return vim.fn.winnr(direction) ~= vim.fn.winnr()
end

-- [[
-- This function is a wrapper which handles all of the resizing keymaps that we will set here
-- ]]
local function resize(direction, amount)
	amount = amount or 2

	if direction == 'left' then
		if has_neighbor('h') then
			vim.cmd('vertical resize +' .. amount)
		elseif has_neighbor('l') then
			vim.cmd('vertical resize -' .. amount)
		end
	elseif direction == 'right' then
		if has_neighbor('l') then
			vim.cmd('vertical resize +' .. amount)
		elseif has_neighbor('h') then
			vim.cmd('vertical resize -' .. amount)
		end
	elseif direction == 'up' then
		if has_neighbor('k') then
			vim.cmd('resize +' .. amount)
		elseif has_neighbor('j') then
			vim.cmd('resize -' .. amount)
		end
	elseif direction == 'down' then
		if has_neighbor('j') then
			vim.cmd('resize +' .. amount)
		elseif has_neighbor('k') then
			vim.cmd('resize -' .. amount)
		end
	end
end

vim.keymap.set('n', '<A-h>', function()
	resize('left')
end, { desc = 'move window divider left' })

vim.keymap.set('n', '<A-l>', function()
	resize('right')
end, { desc = 'move window divider right' })

vim.keymap.set('n', '<A-j>', function()
	resize('down')
end, { desc = 'move window divider down' })

vim.keymap.set('n', '<A-k>', function()
	resize('up')
end, { desc = 'move window divider up' })

-- [[
-- some default wincmd keymaps
--	Split horizontally: <C-w>s
--	Split vertically: <C-w>v
--	Close current window: <C-w>c
-- ]]

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
end, { desc = 'Toggle [q]uickfix list' })

