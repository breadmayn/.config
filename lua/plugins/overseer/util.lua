-- [[
--
-- lua/plugins/overseer/util.lua
--
-- This file denotes utility methods that overseer will use to create fallback task template pattern with scripts
--
-- ]]

local M = {}

-- [[
-- This utility is enhancing the fallback pattern by dynamically discovering scripts in <project>/.nvim/scripts/ directory
-- ]]
function M.get_project_scripts()
	local root = vim.fn.getcwd() -- note that the project root dir is where nvim will be invoked
	local scripts_dir = vim.fs.joinpath(root, '.nvim', 'scripts')

	-- early bail if there is no scripts dir
	if vim.fn.isdirectory(scripts_dir) ~= 1 then
		return {}
	end

	local scripts = {}

	for name, type in vim.fs.dir(scripts_dir) do
		if type == 'file' then
			local path = vim.fs.joinpath(scripts_dir, name)

			if vim.fn.executable(path) == 1 then
				table.insert(scripts, {
					name = name,
					path = path,
					root = root,
				})
			end
		end
	end

	table.sort(scripts, function(a, b)
		return a.name < b.name
	end)

	return scripts
end

return M

