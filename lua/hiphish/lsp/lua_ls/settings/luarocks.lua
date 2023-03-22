--- Convert a list of paths to a table suitable for `Lua.workspace.library`.
local function paths_to_library(paths)
	paths = paths or {}
	local result = {}
	for _, path in ipairs(paths) do result[path .. '/..'] = true end
	-- for _, path in ipairs(paths) do result[path] = true end
	return result
end


--- Convert a list of paths to a list of patterns suitable for use in the
--- `Lua.runtime.path` setting.
--
-- @param paths
--   List of directory paths.
-- @param patterns
--   Optional list of patterns to append to each path.
local function paths_to_require_patterns(paths, patterns)
	paths = paths or {}
	patterns = patterns or {'?.lua', '?/init.lua'}
	local result = {}

	for _, path in ipairs(paths) do
		for _, pattern in ipairs(patterns) do
			result[#result + 1] = path .. pattern
		end
	end

	return result
end


--- Same as running `luarocks path --lr-path`, but result is a list.
local function get_luarocks_paths()
	if vim.fn.executable('luarocks') == 0 then return {} end

	-- Get the value from the command line and split it up. At this point we do
	-- not have the search directories, but the search patterns as used by
	-- `package.path`.
	local output = vim.fn.systemlist({'luarocks', 'path', '--lr-path'})[1]
	local patterns = vim.split(output, ';', true )

	local result, cache = {}, {}
	-- Transform the patterns into directories by stripping off the pattern
	-- part; make sure to remove duplicate paths.
	for _, pattern in ipairs(patterns) do
		local directory = string.gsub(pattern, '?.*$', '')
		if not cache[directory] then
			result[#result + 1] = directory
		end
	end

	return result
end


--- Load modules from Luarocks directory
local M = {
	Lua = {
		runtime = {
			version = vim.fn.systemlist({'lua', '-e', 'print(_VERSION)'}),
			path = paths_to_require_patterns{'5.3/'},
		},

		workspace = {
			library = paths_to_library(get_luarocks_paths())
		},
	}
}

return M
