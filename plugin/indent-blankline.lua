-- SPDX-FileCopyrightText: © 2022 HiPhish
-- SPDX-License-Identifier: 0BSD

local ibl   = require 'ibl'
local hooks = require "ibl.hooks"
local get_option_value = vim.api.nvim_get_option_value

local enabled_for = {'python', 'nim', 'yaml'}

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
}

-- Only enable for select languages
hooks.register(hooks.type.ACTIVE, function(bufnr)
	local ft = get_option_value('filetype', {buf = bufnr})
	return vim.tbl_contains(enabled_for, ft)
end)

-- Use rainbow delimiters to highlight the current scope
hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
