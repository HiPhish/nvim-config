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
local rules = require'hiphish.lsp.lua_ls.rules'


M.config = {
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
