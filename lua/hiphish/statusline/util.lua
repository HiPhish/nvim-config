-- SPDX-FileCopyrightText: © 2022 HiPhish
-- SPDX-License-Identifier: Unlicense

local M = {}

local api = vim.api

M.modes = {
	n        = {label = 'NORMAL'         , short = ' N ', hi = 'Normal'},
	no       = {label = 'NORMAL'         , short = ' N ', hi = 'Normal'},
	nov      = {label = 'NORMAL'         , short = ' N ', hi = 'Normal'},
	noV      = {label = 'NORMAL'         , short = ' N ', hi = 'Normal'},
	['no'] = {label = 'NORMAL'         , short = ' N ', hi = 'Normal'},
	niI      = {label = '(NORMAL)'       , short = '(N)', hi = 'Normal'},
	niR      = {label = '(NORMAL)'       , short = '(N)', hi = 'Normal'},
	niV      = {label = '(NORMAL)'       , short = '(N)', hi = 'Normal'},
	nt       = {label = 'NORMAL'         , short = ' N ', hi = 'Normal'},
	v        = {label = 'VISUAL'         , short = ' v ', hi = 'Visual'},
	vs       = {label = 'VISUAL'         , short = ' v ', hi = 'Visual'},
	V        = {label = 'VISUAL LINE'    , short = ' V ', hi = 'Visual'},
	['']   = {label = 'VISUAL BLOCK'   , short = '[V]', hi = 'Visual'},
	['s']  = {label = 'VISUAL BLOCK'   , short = '[V]', hi = 'Visual'},
	s        = {label = 'SELECT'         , short = ' s ', hi = 'Select'},
	S        = {label = 'SELECT LINE'    , short = ' S ', hi = 'Select'},
	['']   = {label = 'SELECT BLOCK'   , short = '[S]', hi = 'Select'},
	i        = {label = 'INSERT'         , short = ' i ', hi = 'Insert'},
	ic       = {label = 'INSERT'         , short = ' i ', hi = 'Insert'},
	ix       = {label = 'INSERT'         , short = ' i ', hi = 'Insert'},
	R        = {label = 'REPLACE'        , short = ' r ', hi = 'Replace'},
	Rc       = {label = 'VISUAL REPLACE' , short = ' r ', hi = 'Replace'},
	Rx       = {label = 'VISUAL REPLACE' , short = ' r ', hi = 'Replace'},
	Rv       = {label = 'VIRTUAL REPLACE', short = ' r ', hi = 'Replace'},
	Rvc      = {label = 'VIRTUAL REPLACE', short = ' r ', hi = 'Replace'},
	Rvx      = {label = 'VIRTUAL REPLACE', short = ' r ', hi = 'Replace'},
	c        = {label = 'COMMAND'        , short = ' c ', hi = 'Cmd'},
	cv       = {label = 'VIM EX'         , short = ' c ', hi = 'Cmd'},
	ce       = {label = 'EX'             , short = ' c ', hi = 'Cmd'},
	r        = {label = 'PROMPT'         , short = ' c ', hi = 'Cmd'},
	rm       = {label = 'MORE'           , short = ' c ', hi = 'Cmd'},
	['r?']   = {label = 'CONFIRM'        , short = ' c ', hi = 'Cmd'},
	['!']    = {label = 'SHELL'          , short = ' c ', hi = 'Cmd'},
	t        = {label = 'TERMINAL'       , short = ' t ', hi = 'Insert'},
}

-- Links the `StatusLineAccentMode` highlight group to the group of the current
-- mode. Allows us to use the same static highlight group for components and
-- have it automatically match the current mode; avoids many string
-- allocations.
function M.hi_statusline_accent_mode()
	local current_mode = api.nvim_get_mode().mode
	-- If there is no match for the exact mode it is safe to compare the first
	-- letter only according to `:h mode()`
	local spec = M.modes[current_mode] or M.modes[current_mode:sub(1, 1)]
	if not spec then return end
	local hi = spec.hi or ''
	vim.cmd(string.format('hi link StatusLineAccentMode StatusLineAccent%s', hi))
end

-- Wraps a given text inside the highlight group of the current mode
function M.hl_mode(text)
	local current_mode = api.nvim_get_mode().mode
	local spec = M.modes[current_mode] or {}
	local hi = spec.hi or ''

	return string.format('%%#StatusLineAccent%s#%s', hi, text)
end

return M
