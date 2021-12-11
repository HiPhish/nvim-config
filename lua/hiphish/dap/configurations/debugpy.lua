-- Debugpy: https://github.com/microsoft/debugpy

local dap = require 'dap'
local has_dapui = pcall(require, 'dapui')

---Configurations for debugging Python with Debugpy. Some of the exported
---items are prepared configurations, but most are functions which generated a
---configuration on the fly.
local M = {}

local function make_config(config)
	return vim.tbl_extend('keep', config, M.base_config)
end


---[ Public interface ]--------------------------------------------------------

---Base configuration for all configurations; extend it with whatever else is
---needed.
M.base_config = {
	type = 'python',
	request = 'launch',
	console = 'internalConsole',
	justMyCode = false,
}

--- Debug a module by name
function M.debug_module(module)
	local config = make_config {
		name = string.format('Python module \'%s\'', module),
		module = module,
	}

	if not has_dapui then dap.repl.open() end
	dap.run(config)
end

--- Debug a program with optional arguments
function M.debug_program(program, args)
	local config = make_config {
		name = string.format('Python program \'%s\'', program),
		program = program,
		args = args or {},
	}

	if not has_dapui then dap.repl.open() end
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

	if not has_dapui then dap.repl.open() end
	dap.run(config)
end

-------------------------------------------------------------------------------
return M
