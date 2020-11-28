--- Configuration for the Lua language server
--
-- This module returns a sensible configuration for launching the Lua language
-- server. The main issue is the `settings` field of the configuration; it
-- holds the settings which need to be passed to the server to configure it for
-- a particular project.
--
-- I want to provide a sensible set of default settings, while allowing
-- individual projects to specify their own settings. When launching, Neovim
-- looks for a JSON file; if found it loads the file into a table and applies
-- the settings, otherwise it default to settings for a Neovim plugin.
--
-- One downside is that the settings are read once and are then fixed. It would
-- be better if a function was executed.
local M = {}

local util = require'lspconfig'.util
local rules = require'lsp_config.sumneko_lua.rules'


---[ Helpers ]-----------------------------------------------------------------

--- Helper function, gets a Neovim standard path.
local sp = vim.fn.stdpath

--- Where the language server is installed
local install_dir =
	string.format('%s/nvim_lsp/sumneko_lua/lua-language-server', sp'cache')

--- LSP settings, either read from local file or defaulting to Neovim plugin.
local settings = vim.fn.filereadable('lua-lsp.json') ~= 0
	and vim.fn.json_decode(vim.fn.readfile('lua-lsp.json'))
	or require'lsp_config.sumneko_lua.settings'.nvim


-------------------------------------------------------------------------------
M.config = {
	cmd = {
		string.format('%s/bin/%s/lua-language-server', install_dir, jit.os),
		'-E',
		string.format('%s/main.lua', install_dir),
	},

	--- Try the rock specification, followed by the git repository. Fall back
	--- on current directory.
	root_dir = function(fname)
		return util.root_pattern('*.rockspeck')(fname)
			or util.find_git_ancestor(fname)
			or vim.fn.getcwd()
	end,

	settings = rules.apply(),
}

return M.config
