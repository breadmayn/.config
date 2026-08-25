-- [[
--
-- lua/plugins/neotree/keymaps.lua
--
-- This file contains the user (me) defined keymaps related to the plugin manages by this directory
--
-- ]]

return {

	{
		'<leader>e',
		function()
			-- this is a smart toggle where if we have opened a file not in the cwd then we won't follow just reveal the file explorer
			local name = vim.api.nvim_buf_get_name(0)
			local inside = name ~= '' and vim.startswith(name, vim.fn.getcwd() .. '/')

			vim.cmd('Neotree toggle' .. (inside and ' reveal' or ''))
		end,
		desc = 'toggle file [e]xplorer',
	},

}
