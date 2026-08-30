-- SPDX-FileCopyrightText: © 2021 HiPhish
-- SPDX-License-Identifier: Unlicense

--- Table of DAP adapter configurations, maps language onto configuration
--- table.
local M = {}

M.c = {
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

M.cpp = M.c

-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#local-lua-debugger-vscode
M['local-lua'] = {
	name = 'local-lua',
	type = 'executable',
	command = 'node',
	args = {
		vim.env.HOME .. '/Applications/dap/local-lua-debugger-vscode/extension/debugAdapter.js'
	},
	enrich_config = function(config, on_config)
		if not config['extensionPath'] then
			local c = vim.deepcopy(config)
			-- If this is missing or wrong you'll see "module 'lldebugger' not
			-- found" errors in the dap-repl when trying to launch a debug
			-- session.
			c.extensionPath = vim.env.HOME .. '/Applications/dap/local-lua-debugger-vscode'
			on_config(c)
		else
			on_config(config)
		end
	end
}

return M
