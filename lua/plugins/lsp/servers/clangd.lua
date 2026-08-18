-- [[
--
-- lua/lsp/servers/clangd.lua
--
-- This file denotes clangdLS specific configurations
--
-- ]]

-- [[
-- Picks the clangd binary to atch the project type:
--		Xcode projects: use the toolchain's own clangd. xcodebuild emits flags only Apple's clangd understands
--			(-target-arch-variant, -target-variant ...-macabi, arm64e tiples, etc) and upstream clangd rejects them
--		Everything else: uses clangd from path (mason installed)
-- ]]
local function select_clangd_binary()
	local system_clangd_binary_path = '/usr/bin/clangd'

	-- iterate over the files in the parent dir (where NVIM was invoked)
	for name, type in vim.fs.dir(vim.fn.getcwd()) do
		if type == 'directory' and (name:match('%.xcodeproj$') ~= nil or name:match('%.xcworkspace$') ~= nil) then
			if vim.fn.executable(system_clangd_binary_path) == 1 then
				return system_clangd_binary_path
			end
		end
	end

	-- return default mason installed clangd
	return 'clangd'
end


return {
	cmd = {
		select_clangd_binary(),
		'--background-index',
		'--clang-tidy',
		'--header-insertion=iwyu',
		'--completion-style=detailed',
	},
}
