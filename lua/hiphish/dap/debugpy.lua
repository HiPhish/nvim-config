local dap = require 'dap'
local py_path = vim.fn.systemlist('which python')[1]

if py_path then
	require 'dap-python'.setup(py_path)
end

--- Additional Debugpy functions for generating configurations on the fly.
local M = {}

--- Extend this table with custom entries.
local base_config = {
	type = 'python',
	request = 'launch',
	console = 'internalConsole',
}

local function make_config(config)
	return vim.tbl_extend('keep', config, base_config)
end

function M.debug_module(module)
	local config = make_config {
		name = string.format('Debug module \'%s\'', module),
		module = module,
	}

	dap.repl.open()
	dap.run(config)
end

return M
