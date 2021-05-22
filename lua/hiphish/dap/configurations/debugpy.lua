-- Debugpy: https://github.com/microsoft/debugpy

local dap = require 'dap'
-- Running tests: https://github.com/mfussenegger/nvim-dap-python/
local has_testrunners, dap_python = pcall(require, 'dap-python')
local fn = vim.fn

--- Configurations for debugging Python with Debugpy. Some of the exported
--- items are prepared configurations, but most are functions which generated a
--- configuration on the fly.
local M = {}

local pythonpath = fn.systemlist('which python3')[1]
	or fn.systemlist('which python')[1]
local pippath = fn.systemlist('which pip3')[1]
	or fn.systemlist('which pip')[1]

--- Figure out whether a module is installed via pip.
local function has_module(name)
	local modules = fn.systemlist({pippath, 'list'})
	for _, line in ipairs(modules) do
		if fn.match(line, '\\v^' .. name) >= 0 then return true end
	end
	return false
end

-- Determine Python path automatically, should be able to handle virtual
-- environments.
dap_python.setup(pythonpath)

-- Make an educated guess about the test runner
if has_module('pytest') then
	dap_python.test_runner = 'pytest'
end

local function make_config(config)
	return vim.tbl_extend('keep', config, M.base_config)
end

local function print_dap_python_info()
	local messages = {
		{'Plugin \'nvim-dap-python\' not installed', 'ErrorMsg'},
		{"\n"},
		{'Please install the plugin from https://github.com/mfussenegger/nvim-dap-python/\n'},
	}
	vim.api.nvim_echo(messages, true, {})
end


---[ Public interface ]--------------------------------------------------------

--- Base configuration for all configurations; extend it with whatever else is
-- needed.
M.base_config = {
	type = 'python',
	request = 'launch',
	console = 'internalConsole',
}

--- Debug a module by name
function M.debug_module(module)
	local config = make_config {
		name = string.format('Python module \'%s\'', module),
		module = module,
	}

	dap.repl.open()
	dap.run(config)
end

--- Debug a program with optional arguments
function M.debug_program(program, args)
	local config = make_config {
		name = string.format('Python program \'%s\'', program),
		program = program,
		args = args or {},
	}

	dap.repl.open()
	dap.run(config)
end

--- Debug a remote process using SSH and port forwarding
function M.debug_remote(host, port)
	local config = make_config {
		name = string.format('Remote process at \'%s@%s\'', host, port),
		request = 'attach',
		pathMappings = {
			-- Maps local current working directory to remote working directory
			localRoot = '${workspaceFolder}',
			remoteRoot = '.'
		},
	}

	dap.repl.open()
	dap.run(config)
end

--- Debug the nearest test function or method
function M.debug_test()
	if not has_testrunners then
		print_dap_python_info()
		return
	end
	dap.repl.open()
	dap_python.test_method(M.base_config)
end

--- Debug the nearest test class
function M.debug_class()
	if not has_testrunners then
		print_dap_python_info()
		return
	end
	dap.repl.open()
	dap_python.test_class(M.base_config)
end

--- Debug the visually selected code
function M.debug_selection()
	if not has_testrunners then
		print_dap_python_info()
		return
	end
	dap.repl.open()
	dap_python.debug_selection(M.base_config)
end


-------------------------------------------------------------------------------
return M
