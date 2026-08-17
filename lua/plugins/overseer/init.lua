-- [[
--
-- lua/plugins/overseer/init.lua
--
-- This file will import overseer.lua and include our configuration of the plugin
--
-- Overseer is a plugin which provides a job manager/task runner. This will help in handling
-- project specific tasks which we will establish a structure to handle and implement.
--
-- ]]

-- load keymaps from keymap file
local keymaps = require('plugins.overseer.keymaps')

return {
	'stevearc/overseer.nvim',

	-- denote commands that can be run without overseer already being loaded
	-- note: invoking these will forcefully load overseer
	cmd = {
		'OverseerRun',
		'OverseerToggle',
		'OverseerTaskAction',
	},

	-- keymaps related to managing overseer functionality
	keys = keymaps,

	opts = {},

	config = function(_, opts)
		local overseer = require('overseer')

		overseer.setup(opts)

		-- registering script fallback template if necessary (this is conditionalized already if a scripts dir exist)
		overseer.register_template(
			require('plugins.overseer.providers.scripts')
		)
	end,
}

