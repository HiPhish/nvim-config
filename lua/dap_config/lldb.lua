local dap = require 'dap'

dap.adapters.lldb = {
		type = 'executable',
		attach = {
			pidProperty = "pid",
			pidSelect = "ask"
		},
		command = 'lldb-vscode-10', -- my binary was called 'lldb-vscode-11'
		env = {
			LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
		},
		name = "lldb"
	}

local M = {}
local last_lldb_config

M.start_c_debugger = function(args, mi_mode, mi_debugger_path)
	if args and #args > 0 then
		last_lldb_config = {
			type = "lldb",
			name = args[1],
			request = "launch",
			program = table.remove(args, 1),
			args = args,
			cwd = vim.fn.getcwd(),
			-- env = {"VAR1=value1", "VAR2=value"}, -- environment variables are set via `ENV_VAR_NAME=value` pairs
			externalConsole = true,
			MIMode = mi_mode or "gdb",
			MIDebuggerPath = mi_debugger_path
		}
	end
	
	if not last_lldb_config then
	    print('No binary to debug set! Use ":DebugC <binary> <args>" or ":DebugRust <binary> <args>"')
	    return
	end
	
	dap.run(last_lldb_config)
	dap.repl.open()
end

vim.cmd [[
    command! -complete=file -nargs=* DebugC lua require "dap_config.lldb".start_c_debugger({<f-args>}, "gdb")
]]

return M
