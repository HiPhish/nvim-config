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
local rules = require'hiphish.lsp.lua_ls.rules'

return {
	cmd = {'lua-language-server'},
    filetypes = {'lua'},
	root_markers = {'.luarc.json', '*.rockspeck', '.git'},
	settings = rules.apply(),
}
