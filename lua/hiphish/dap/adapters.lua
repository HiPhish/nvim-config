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

M.python = {
	name = 'python',
	type = 'executable',
	command = '/usr/bin/python3',
	args = {'-m', 'debugpy.adapter'}
}


return M
