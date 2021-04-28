local dap = require 'dap'

local adapters       = dap.adapters
local configurations = dap.configurations


--- [ OPTIONS ]----------------------------------------------------------------
vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='🔵', texthl='', linehl='', numhl=''})


--- [ KEY MAPPINGS ]-----------------------------------------------------------
do
	local opts = {noremap = true, silent = true}
	local mappings = {
		{'<F3>' , '<cmd>lua require"dap".toggle_breakpoint()<CR>'},
		{'<F5>' , '<cmd>lua require"dap".continue()<CR>'         },
    	{'<F10>', '<cmd>lua require"dap".step_over()<CR>'        },
    	{'<F11>', '<cmd>lua require"dap".step_into()<CR>'        },
    	{'<F12>', '<cmd>lua require"dap".step_out()<CR>'         },
	}

	for _, mapping in pairs(mappings) do
		local lhs = mapping[1]
		local rhs = mapping[2]
		vim.api.nvim_buf_set_keymap(0, 'n', lhs, rhs, opts)
	end
end


--- [ C FAMILY ]---------------------------------------------------------------
adapters.c = {
	name = 'lldb-vscode',
	type = 'executable',
	attach = {
		pidProperty = "pid",
		pidSelect = "ask"
	},
	command = 'lldb-vscode',
	args = {},
	LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
	options = {
		env = {
			LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
		},
	},
}

adapters.cpp = adapters.c


--- [ PYTHON ] ----------------------------------------------------------------
adapters.python = {
	name = 'python',
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
