-- [[
--
-- lua/plugins/overseer/providers/scripts.lua
--
-- This file denotes a fallback pattern which utilizes a utility function we created in lua/plugins/overseer/util.lua
--
-- Specifically, if overseer doesn't find Makefiles or cmake or any other build system related files, overseer will fallback to finding build/test/configure scripts
-- in a scripts directory in the project's root directory
--
-- note: projects are able to disable this fallback by not having a scripts in the root project dir (<project name>/scripts/)
--
-- ]]

-- include find_project_script utility
local util = require('plugins.overseer.util')

return {
	-- name required for overseer template schema
	name = 'project scripts',

	-- template generator for overseer for all scripts in <project>/scripts/ dir
	generator = function()
		local templates = {}

		-- for all scripts that we find using get_project_scripts() create a template
		for _, script in ipairs(util.get_project_scripts()) do
			local task = script
			local name = 'script: ' .. task.name

			table.insert(templates, {
				name = name,

				builder = function()
					return {
						name = name,
						cmd = { task.path },
						cwd = task.root,
						components = { 'default' },
					}
				end,
			})
		end

		return templates
	end,
}

