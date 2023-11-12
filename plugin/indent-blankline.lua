local ibl   = require 'ibl'
local hooks = require "ibl.hooks"

ibl.setup {
	enabled = true,
	indent = {
		char = '▏',
	},
	scope = {
		char = '▎',
		show_start = false,
		show_end = false,
		highlight = {
    		"RainbowRed",
    		"RainbowYellow",
    		"RainbowBlue",
    		"RainbowGreen",
    		"RainbowCyan",
    		"RainbowOrange",
    		"RainbowViolet",
		},
	},
	exclude = {
		filetypes = {'*'}
	}
}

-- Use rainbow delimiters to highlight the current scope
hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
