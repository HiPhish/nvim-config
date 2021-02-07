--- Various predefined settings for the language server
local M = {}

-- NOTE
--
-- The values of `Lua.runtime.path` and `Lua.workspace.library` are still a
-- mystery to me. According to the author it works as follows:
--
--   - `Lua.runtime.path` is used for `require` and contains the same patterns
--     as `package.path` in Lua, except as a list table instead of a string
--   - `Lua.library.workspace` is a table with paths for keys; these paths are
--     recursively searched for global definitions.
--
-- Either his explanation is wrong, or the code does not work properly. The
-- below values are just me randomly poking at things until everything works,
-- or at least seems to work.
--
-- Here are my findings:
--
--   - The directories in `Lua.workspace.library` need to be one level *above*
--     the directory containing the modules. E.g. for Luarocks use
--     `~/.luarocks/share/lua` instead of `~/.luarocks/share/lua/5.3`
--
--   - The patterns in `Lua.runtime.require` should be the usual patterns (e.g.
--     `{'?.lua', '?/init.lua}`, except prefixed with the directory missing
--     from above. E.g. for Luarocks use `{'5.3/?.lua', '5.3/?/init.lua'}`
--
-- Any other combination seems to produce either too many (and wrong)
-- suggestions, or the symbol cannot be resolved.


-- [ HELPER FUNCTIONS ]--------------------------------------------------------

--- Collect all Neovim Lua directories (including the ones from plugins).
local function get_runtime_paths()
    local result = {};
    for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
        local lua_path = path .. '/lua/';
        if vim.fn.isdirectory(lua_path) ~= 0 then
            -- result[#result + 1] = path
            result[#result + 1] = lua_path
        end
    end

    return result;
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


-- [ SETTINGS ]----------------------------------------------------------------

--- Default settings, used by all other settings
-- This table forms a basis of my personal defaults which I want to use for all
-- other configurations. More concrete settings should overwrite and extend
-- this table.
M.default = {
	Lua = {
		completion = {
			callSnippet = 'Both'
		},
		workspace = {
			maxPreload = 1000,
			preloadFileSize = 1000,
		},
	}
}


--- Settings suitable for writing Neovim configuration and plugins.
M.nvim = {
	Lua = {
		runtime = {
			version = 'LuaJIT',
			path = paths_to_require_patterns({'lua/'})
		},

		diagnostics = {
			globals = {
				-- Neovim
				'vim',
				-- Busted
				'describe', 'it', 'before_each', 'after_each', 'teardown', 'pending'
			},
		},

		workspace = {
			library = paths_to_library(get_runtime_paths())
		},
	}
}


--- Load modules from Luarocks directory
M.luarocks = {
	Lua = {
		runtime = {
			version = 'Lua 5.3',
			path = paths_to_require_patterns{'5.3/'}
		},

		workspace = {
			library = paths_to_library(get_luarocks_paths())
		},
	}
}


return M
