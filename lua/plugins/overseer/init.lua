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
	keys = require('plugins.overseer.keymaps'),

	opts = {},

	config = function(_, opts)
		local overseer = require('overseer')

		overseer.setup(opts)

		-- registering script fallback template if necessary (this is conditionalized already if a scripts dir exist)
		overseer.register_template(
			require('plugins.overseer.providers.scripts')
		)

		-- adding hook for (broad/general) quickfix task list
		-- note: although we hooked up the quickfix list into overseer - quickfix is not strictly overseer related, keymaps are in nvim keymaps
		overseer.add_template_hook({}, function(task_defn, util)
			util.add_component(task_defn, {
				'on_output_quickfix',
				open = false, -- certain overseer tasks might not have a valid output. lets not always open the quickfix list
			})
		end)

	end,
}

