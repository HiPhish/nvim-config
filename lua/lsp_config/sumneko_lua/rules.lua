local settings = require'lsp_config.sumneko_lua.settings'


-- [ TESTS ] ------------------------------------------------------------------

--- Test which will always pass
local function always()
	return true
end

local function has_local_settings_file()
	return vim.fn.filereadable('lua-lsp.json') ~= 0
end

--- Whether the current directory is the Neovim config directory.
local function is_nvim_conf_dir()
	return vim.fn.getcwd() == vim.fn.stdpath('config')
end


-- [ RULES ] ------------------------------------------------------------------
--- Rules sorted by priority in descending order
local rules = {
	{
		test = always,
		settings = settings.default,
		strict = false,
	}, {
		test = has_local_settings_file,
		settings = function ()
			vim.fn.json_decode(vim.fn.readfile('lua-lsp.json'))
		end,
		strict = true,
	}, {
		test = is_nvim_conf_dir,
		settings = settings.nvim,
		strict = true,
	}
}


-------------------------------------------------------------------------------
return {
	append = function(rule)
		rules[#rules+1] = rule
	end,

	apply = function()
		local result = {}
		for _, rule in ipairs(rules) do
			if rule.test() then
				local current = type(rule.settings) == 'function'
					and rule.setting()
					or rule.settings
				result = vim.tbl_deep_extend('force', result, current)
				if rule.strict then
					break
				end
			end
		end

		return result
	end
}
