local tests    = require'hiphish.lsp.sumneko_lua.tests'


-- [ RULES ] ------------------------------------------------------------------
-- Each rule has a priority which determines whether the rule will be applied:
-- if the priority of the rule is greater than the current priority, then apply
-- it and set the current priority to the priority of the rule. This allows
-- certain rules to block lesser rules from being applied. In particular, this
-- means that no two rules of equal priority will be both applied.

--- Rules sorted by order of application.
local rules = {
	{
		test = tests.always,
		settings = require 'hiphish.lsp.sumneko_lua.settings.default',
		priority = 0,
	}, {
		test = tests.has_rockspec,
		settings = require 'hiphish.lsp.sumneko_lua.settings.luarocks',
		priority = 1,
	}, {
		test = tests.any(
			tests.config_dir,
			tests.plugin_dir
		),
		settings = require 'hiphish.lsp.sumneko_lua.settings.nvim',
		priority = 1,
	}, {
		test = tests.file('main.lua'),
		-- test = tests.never,
		settings = require 'hiphish.lsp.sumneko_lua.settings.love2d',
		priority = 1,
	},
}


-------------------------------------------------------------------------------
return {
	append = function(rule)
		rules[#rules+1] = rule
	end,

	apply = function()
		local result = {}
		local priority = -1
		for _, rule in ipairs(rules) do
			if priority < rule.priority and rule.test() then
				priority = rule.priority
				local current = type(rule.settings) == 'function'
					and rule.settings()
					or rule.settings
				result = vim.tbl_deep_extend('force', result, current)
			end
		end

		return result
	end
}
