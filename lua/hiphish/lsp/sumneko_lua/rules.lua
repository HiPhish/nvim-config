local settings = require'hiphish.lsp.sumneko_lua.settings'
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
		settings = settings.default,
		priority = 0,
	}, {
		test = tests.has_local_settings_file,
		settings = function ()
			vim.fn.json_decode(vim.fn.readfile('lua-lsp.json'))
		end,
		priority = 3,
	}, {
		test = tests.has_rockspec,
		settings = settings.luarocks,
		priority = 1,
	}, {
		test = tests.is_nvim_conf_dir,
		settings = settings.nvim,
		priority = 1,
	}, {
		test = tests.is_vim_plugin_dir,
		settings = function ()
			local result = settings.nvim
			local cwd = vim.fn.getcwd()
			if vim.fn.isdirectory(cwd .. '/lua') ~= 0 then
				result.Lua.workspace.library[cwd .. '/lua/..'] = true
			end
			return result
		end,
		priority = 1,
	}, {
		test = tests.has_local_extra_file,
		settings = function ()
			vim.fn.json_decode(vim.fn.readfile('lua-lsp-extra.json'))
		end,
		priority = 3,
	}
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
