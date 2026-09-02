-- SPDX-FileCopyrightText: © 2020 HiPhish
-- SPDX-License-Identifier: 0BSD

local fn = vim.fn

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

--- Whether the file path argument is a directory.
local function isdirectory(directory)
	return fn.isdirectory(directory) ~= 0
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

	return { [dir] = map(fn.readdir(path), f) }
end


-- [ TESTS ] ------------------------------------------------------------------

--- Test which will always pass.
function M.always()
	return true
end

--- Test which will always fail.
function M.never()
	return false
end

--- Returns a test which passes if and only if all its argument tests pass.
--- @param ... function  Individual tests
function M.all(...)
	local tests = {...}
	return function()
		for _, test in ipairs(tests) do
			if not test() then return false end
		end
		return true
	end
end

--- Returns a test which passes if any of its argument tests pass.
--- @param ... function  Individual tests
function M.any(...)
	local tests = {...}
	return function()
		for _, test in ipairs(tests) do
			if test() then return true end
		end
		return false
	end
end

--- Returns a test which passes if the given file is readable.
function M.file(fname)
	return function ()
		return fn.filereadable(fname) ~= 0
	end
end

--- Returns a test which passes if the current working directory is the same as
--- the given path.
function M.cwd(path)
	return function ()
		return fn.getcwd() == path
	end
end

---Whether the current working directory is the standard configuration
---directory.
M.config_dir = M.cwd(vim.fn.stdpath('config'))

--- The current directory is a Vim plugin directory; only an educated guess.
function M.plugin_dir()
	-- This is flawed because it does not search sub-directories of 'autoload'.
	local plugin_dirs = {'plugin', 'autoload', 'after/plugin'}
	for _, plugin_dir in ipairs(plugin_dirs) do
		if isdirectory(plugin_dir) then
			local vim_files = fn.glob(plugin_dir .. '/*.vim')
			local lua_files = fn.glob(plugin_dir .. '/*.lua')
			if #vim_files + #lua_files > 0 then return true end
		end
	end

	-- Plugin directory names usually end in `.nvim` or start with `nvim-`
	return
		fn.fnamemodify(fn.getcwd(), ':e') == 'nvim'
		or fn.matchstr(fn.fnamemodify(fn.getcwd(), ':t'), '\\v^nvim-.+') ~= ''
end

--- There exists a `.rockspec` file.
function M.has_rockspec()
	local specs = fn.glob('*.rockspec', true, true)
	return #specs > 0
end


-------------------------------------------------------------------------------
return M
