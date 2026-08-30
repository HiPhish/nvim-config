-- SPDX-FileCopyrightText: © 2021 HiPhish
-- SPDX-License-Identifier: Unlicense

local dap = require 'dap'
local ui  = require 'dapui'
local vt  = require 'nvim-dap-virtual-text'


---[ CONFIGURATION ]-----------------------------------------------------------
local signs = {
	DapBreakpoint = {text='●', texthl='LspDiagnosticsDefaultError'},
	DapLogPoint = {text='◉', texthl='LspDiagnosticsDefaultError'},
	DapStopped = {text='🞂', texthl='LspDiagnosticsDefaultInformation', linehl='CursorLine'},
}

local mappings = {
	['<F3>' ] = '<cmd>lua require"dap".toggle_breakpoint()<CR>',
	['<F5>' ] = '<cmd>lua require"dap".continue()<CR>',
    ['<F10>'] = '<cmd>lua require"dap".step_over()<CR>',
    ['<F11>'] = '<cmd>lua require"dap".step_into()<CR>',
    ['<F12>'] = '<cmd>lua require"dap".step_out()<CR>',
}


for sign, options in pairs(signs) do
	vim.fn.sign_define(sign, options)
end

for lhs, rhs in pairs(mappings) do
	vim.api.nvim_set_keymap('n', lhs, rhs, {noremap = true, silent = true})
end

for language, adapter in pairs(require 'hiphish.dap.adapters') do
	dap.adapters[language] = adapter
end

for language, configurations in pairs(require 'hiphish.dap.configurations') do
	dap.configurations[language] = configurations
end


---[ CALLBACKS ]---------------------------------------------------------------
dap.listeners.after['event_initialized']['dapui_config'] = function()
	ui.open({})
end

dap.listeners.before['event_terminated']['dapui_config'] = function()
	ui.close({})
end

dap.listeners.before['event_exited']['dapui_config'] = function()
	ui.close({})
end


----[ VIRTUAL TEXT ]-----------------------------------------------------------
vt.setup {}


---[ DAP UI ]------------------------------------------------------------------
ui.setup {
	mappings = {
		expand = {'<CR>', '<LeftMouse>'},
		open = {'o'},
		remove = {'d', 'x'},
		edit = {'c'},
		repl = {'r'},
	},
	layouts = {
		{
			elements = {
				'breakpoints',
				'watches',
				'stacks',
				'scopes',
			},
			size = 40,
			position = 'right',
		}, {
			elements = {'repl'},
			size = 10,
			position = 'bottom',
		},
	},
	floating = {
		max_height = nil,  -- Either absolute integer or float
		max_width  = nil,  -- between 0 and 1 (size relative to screen size)
	},
}

-- Prompt the user for an expression to evaluate
local function dapui_eval()
	local expr = vim.fn.input('DAP expression: ')
	if vim.fn.empty(expr) ~= 0 then
		return
	end
	ui.eval(expr, {})
end

vim.keymap.set({'n', 'v'}, '<M-k>', ui.eval, {})
vim.keymap.set('n', '<M-K>', dapui_eval, {})
