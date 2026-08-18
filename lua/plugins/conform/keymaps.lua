-- [[
-- 
-- lua/plugins/conform/keymaps.lua
--
-- Thie file contains the user (me) defined keymaps related to the plugin manages by this directory
--
-- ]]

return {

	{
		"<leader>f",
		function()
			require("conform").format()
		end,
		desc = "[f]ormat current buffer",
	},

}

