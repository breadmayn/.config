-- [[
--
-- lua/plugins/autopairs/rules.lua
--
-- This file denotes the autopairs that we would like as well as the filetypes to enable the rule
--
-- ]]

local autopairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

local c_family = {
	"c",
	"cpp",
	"objc",
	"objcpp",
}

autopairs.add_rules({
	-- angle brackets
	Rule("<", ">", c_family)
		:with_pair(cond.before_regex("#include%s$", 20)),
})

