-- See https://gist.github.com/folke/fe5d28423ea5380929c3f7ce674c41d8

-- Directory prefix of all package directories
local package_prefix = vim.fn.expand(vim.fn.stdpath('data') .. '/site/')

---Predicate which is only true for paths that belong to a package and have Lua
---modules.
---@param path string
---@return boolean
local function is_package_path(path)
	if package_prefix ~= string.sub(path, 1, #package_prefix) then
		return false
	end
	return vim.fn.isdirectory(path .. '/lua') ~= 0
end

-- In addition to the current workspace, which directories will load files
-- from. The files in these directories will be treated as externally provided
-- code libraries, and some features (such as renaming fields) will not modify
-- these files.
--
-- Very important: do not include the '/lua' subdirectory in the above paths!
-- The runtime.path entry takes care of that.
local library = vim.tbl_filter(is_package_path, vim.api.nvim_get_runtime_file('', true))


-- https://github.com/sumneko/vscode-lua/blob/master/setting/schema.json
local M = {
	Lua = {
		runtime = {
			version = jit and 'LuaJIT' or _VERSION,
			-- When using `require`, how to find the file based on the input
			-- name.Setting this config to `?/init.lua` means that when you enter
			-- `require 'myfile'`, `${workspace}/myfile/init.lua` will be searched from
			-- the loaded files. if `runtime.pathStrict` is `false`,
			-- `${workspace}/**/myfile/init.lua` will also be searched. If you want to
			-- load files outside the workspace, you need to set `Lua.workspace.library`
			-- first.
			path = {
				'lua/?.lua',
				'lua/?/init.lua',
			},
			-- When enabled, `runtime.path` will only search the first level of
			-- directories, see the description of `runtime.path`.
			pathStrict = true,
		},
		diagnostics = {
			globals = {'vim', jit and 'jit'},
		},
		workspace = {
			library = library,
			-- Ignore the fake user directory structure in plugins.  This
			-- should be part of the `.luarc.json` of the plugin, but for some
			-- reason that does not work, so I define it here instead.
			ignoreDir = {'test/xdg'},
		},
	}
}

return M
