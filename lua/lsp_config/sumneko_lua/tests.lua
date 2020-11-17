--- Various predefined tests for the language server
--
-- A test is a thunk which tests whether some condition is true. Usually we
-- test whether a certain file exists, but we can in theory test for anything.
local M = {}


-- [ HELPERS ] ----------------------------------------------------------------
local function map(list, fun)
	local result = {}
	for _, item in ipairs(list) do result[#result+1] = fun(item) end
	return result
end

local function filereadable(fname)
	return vim.fn.filereadable(fname) ~= 0
end

local function isdirectory(directory)
	return vim.fn.isdirectory(directory) ~= 0
end

--- Returns a directory tree.
--
-- This should be a generator so we can abort as soon as we find a matching
-- file.
--
-- @param[type=string] dir
--   The root directory of the tree, defaults to '.'.
-- @param[type=string] parent
--   Path to the root directory, relative to current working directory,
--   defaults to '.'.
local function tree(dir, parent, when)
	dir = dir or '.'
	parent = parent or '.'
	when = when or function(fname) return string.sub(fname, 1, 1) == '.' end

	local path = parent .. '/' .. dir
	local function f(child)
		return isdirectory(path .. '/' .. child) and tree(child, path) or child
	end

	return { [dir] = map(vim.fn.readdir(path), f) }
end


-- [ TESTS ] ------------------------------------------------------------------

--- Test which will always pass
function M.always()
	return true
end

--- There is a local primary LSP settings file.
function M.has_local_settings_file()
	return filereadable('lua-lsp.json')
end

--- There is a local secondary LSP settings file.
function M.has_local_extra_file()
	return filereadable('lua-lsp-extra.json')
end

--- The current directory is the Neovim config directory.
function M.is_nvim_conf_dir()
	return vim.fn.getcwd() == vim.fn.stdpath('config')
end

--- The current directory is a Vim plugin directory; only an educated guess.
function M.is_vim_plugin_dir()
	-- This is flawed because it does not search sub-directories of 'autoload'.
	local plugin_dirs = {'plugin', 'autoload'}
	for _, plugin_dir in ipairs(plugin_dirs) do
		if isdirectory(plugin_dir) then
			local vim_files = vim.fn.glob('*.vim')
			if #vim_files > 0 then return true end
		end
	end

	return false
end

--- There exists a `.rockspec` file.
function M.has_rockspec()
	local specs = vim.fn.glob('*.rockspec', true, true)
	return #specs > 0
end


-------------------------------------------------------------------------------
return M
