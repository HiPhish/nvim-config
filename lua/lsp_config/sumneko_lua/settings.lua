--- Various predefined settings for the language server
local M = {}


-- [ HELPER FUNCTIONS ]--------------------------------------------------------

--- Collect all Neovim Lua directories (including the ones from plugins).
local function get_lua_runtime()
    local result = {};
    for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
        local lua_path = path .. '/lua/';
        if vim.fn.isdirectory(lua_path) then
            result[lua_path] = true
        end
    end

    -- This loads the `lua` files from nvim into the runtime.
    result[vim.fn.expand('$VIMRUNTIME/lua')] = true

    return result;
end


-- [ SETTINGS ]----------------------------------------------------------------

--- Default settings, used by all other settings
-- This table forms a basis of my personal defaults which I want to use for all
-- other configurations. More concrete settings should overwrite and extend
-- this table.
M.default = {
	Lua = {
		runtime = {
			path = {'?.lua', '?/init.lua', '?/?.lua'}
		},
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
			path = vim.tbl_flatten {
				M.default.Lua.runtime.path,
				vim.split(package.path, ';')
			},
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

return M
