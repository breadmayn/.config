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
	local xcode_project = vim.fs.find(function(name, _)
		return name:match('%.xcodeproj$') ~= nil or name:match('%.xcworkspace$') ~= nil
	end, {
		path = vim.fn.getcwd(),
		upward = true,
		type = 'directory',
		limit = 1,
	})

	if #xcode_project > 0 and vim.fn.executable('/usr/bin/clangd') == 1 then
		return '/usr/bin/clangd'
	end

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
