-- [[
--
-- lua/plugins/log_highlight.lua
--
-- This file will import log-highlight.nvim and include our configurations of the plugin
--
-- Log-highlight is a plugin that provides a robust log viewer
--
-- ]]

return {
	"fei6409/log-highlight.nvim",

	-- lazily load this plugin once we open a .log file
	ft = {
		"log",
	},

	opts = {
		extension = "log", -- default

		filename = {
			"syslog", -- example from the README
		},

		pattern = {
			"%/var%/log%/.*",
			"console%-ramoops.*",
			"log.*%.txt",
			"logcat.*",
		},

		-- denote keyword that should get highlighed
		keyword = {
			error = { "ERROR", "FATAL", "PANIC", "CRITICAL" },
			warning = { "WARN", "WARNING" },
			info = { "INFO", "NOTICE" },
			debug = { "DEBUG", "TRACE" },
			pass = { "PASS", "OK", "SUCCESS" },
		},
	},
}

