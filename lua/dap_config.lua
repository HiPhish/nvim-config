local dap = require 'dap'
dap.set_log_level('trace')


--- [ PYTHON ] ----------------------------------------------------------------
dap.adapters.python = {
	type = 'executable',
	command = '/usr/bin/python3',
	args = {'-m', 'debugpy.adapter'}
}


dap.configurations.python = {
	{
		type = 'python',
		request = 'launch',
		name = 'Launch file',
		program = "${file}",
		pythonPath = function(adapter)
			-- Should be able to handle virtual environment as well
			return '/usr/bin/python3'
		end,
	}
}


--- [ KEY MAPPINGS ]-----------------------------------------------------------
do
	local opts = {noremap = true, silent = true}
	local mappings = {
		{'<F4>' , '<cmd>lua require"dap".continue()<CR>'},
		{'<F3>' , '<cmd>lua require"dap".toggle_breakpoint()<CR>'},
    	{'<F10>', '<cmd>lua require"dap".step_over()<CR>'},
    	{'<F11>', '<cmd>lua require"dap".step_into()<CR>'},
    	{'<F12>', '<cmd>lua require"dap".step_out()<CR>'},
	}

	for mapping in mappings do
		local lhs = mapping[1]
		local rhs = mapping[2]
		vim.fn.nvim_buf_set_keymap(0, 'n', lhs, rhs, opts)
	end
end
