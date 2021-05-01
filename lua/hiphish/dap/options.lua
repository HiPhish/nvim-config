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
	vim.api.nvim_buf_set_keymap(0, 'n', lhs, rhs, {noremap = true, silent = true})
end
