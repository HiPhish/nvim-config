local settings = require'lsp_config.sumneko_lua.settings'


-- [ TESTS ] ------------------------------------------------------------------

--- Test which will always pass
local function always()
	return true
end

--- There is a local primary LSP settings file.
local function has_local_settings_file()
	return vim.fn.filereadable('lua-lsp.json') ~= 0
end

--- There is a local secondary LSP settings file.
local function has_local_extra_file()
	return vim.fn.filereadable('lua-lsp-extra.json') ~= 0
end

--- Whether the current directory is the Neovim config directory.
local function is_nvim_conf_dir()
	return vim.fn.getcwd() == vim.fn.stdpath('config')
end


-- [ RULES ] ------------------------------------------------------------------
-- Each rule has a priority which determines whether the rule will be applied:
-- if the priority of the rule is greater than the current priority, then apply
-- it and set the current priority to the priority of the rule. This allows
-- certain rules to block lesser rules from being applied. In particular, this
-- means that no two rules of equal priority will be both applied.

--- Rules sorted by order of application.
local rules = {
	{
		test = always,
		settings = settings.default,
		priority = 0,
	}, {
		test = has_local_settings_file,
		settings = function ()
			vim.fn.json_decode(vim.fn.readfile('lua-lsp.json'))
		end,
		priority = 3,
	}, {
		test = is_nvim_conf_dir,
		settings = settings.nvim,
		priority = 1,
	}, {
		test = has_local_extra_file,
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
					and rule.setting()
					or rule.settings
				result = vim.tbl_deep_extend('force', result, current)
			end
		end

		return result
	end
}
