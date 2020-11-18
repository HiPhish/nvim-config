--- Various predefined settings for the language server
local M = {}


-- [ HELPER FUNCTIONS ]--------------------------------------------------------

--- Collect all Neovim Lua directories (including the ones from plugins).
local function get_lua_runtime()
    local result = {};
    for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
        local lua_path = path .. '/lua/';
        if vim.fn.isdirectory(lua_path) ~= 0 then
            result[lua_path] = true
        end
    end

    -- This loads the `lua` files from nvim into the runtime.
    result[vim.fn.expand('$VIMRUNTIME/lua')] = true

    return result;
end

--- Same as running `luarocks path --lr-path`, but result is a list.
local function get_luarocks_paths()
	if vim.fn.executable('luarocks') == 0 then return {} end
	return vim.split(vim.fn.systemlist({'luarocks', 'path', '--lr-path'})[1], ';', true)
end

--- Convert a list of paths to a table suitable for `Lua.workspace.library`.
local function paths_to_library(paths)
	local result = {}
	for _, path in ipairs(paths) do result[#result+1] = {[path] = true} end
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


--- Settings suitable for writing Neovim plugins.
M.nvim = {
	Lua = {
		runtime = {
			version = 'LuaJIT',
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
			library = get_lua_runtime()
		},
	}
}


--- Load modules from Luarocks directory
M.luarocks = {
	Lua = {
		runtime = {
			version = 'Lua 5.3',
		},
		workspace = {
			-- TODO: strip the qutestion mark form the paths
			library = paths_to_library(get_luarocks_paths())
		},
	}
}


return M
