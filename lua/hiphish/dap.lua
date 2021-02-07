local dap = require 'dap'
dap.set_log_level('trace')

local adapters       = dap.adapters
local configurations = dap.configurations

--- [ C FAMILY ]---------------------------------------------------------------
require 'hiphish.dap.lldb'  -- Defines adapter and sets up command


--- [ KOTLIN DEBUG ADAPTER ]---------------------------------------------------
require 'hiphish.dap.kotlin'


--- [ PYTHON ] ----------------------------------------------------------------
adapters.python = {
	type = 'executable',
	command = '/usr/bin/python3',
	args = {'-m', 'debugpy.adapter'}
}


configurations.python = {
	{
		type = 'python',
		request = 'launch',
		name = 'Launch file',
		program = "${file}",
		console = 'internalConsole',
	}
}


--- [ KEY MAPPINGS ]-----------------------------------------------------------
do
	local opts = {noremap = true, silent = true}
	local mappings = {
		{'<F3>' , '<cmd>lua require"dap".toggle_breakpoint()<CR>'},
		{'<F4>' , '<cmd>lua require"dap".continue()<CR>'         },
    	{'<F10>', '<cmd>lua require"dap".step_over()<CR>'        },
    	{'<F11>', '<cmd>lua require"dap".step_into()<CR>'        },
    	{'<F12>', '<cmd>lua require"dap".step_out()<CR>'         },
	}

	for _, mapping in pairs(mappings) do
		local lhs = mapping[1]
		local rhs = mapping[2]
		vim.fn.nvim_buf_set_keymap(0, 'n', lhs, rhs, opts)
	end
end
