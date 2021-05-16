--- Table of DAP adapter configurations, maps language onto list of
--- configurations.
local M = {}

M.python = {
	{
		type = 'python',
		request = 'launch',
		name = 'Launch file',
		program = "${file}",
		console = 'internalConsole',
		pythonPath = function()
			return vim.fn.systemlist('which python3')[1]
		end
	}
}

M.scala = {
	{
		type = 'scala',
		request = 'launch',
		name = 'Run',
		metals = {
			runType = 'run',
		},
	}, {
		type = 'scala',
		request = 'launch',
		name = 'Test file',
		metals = {
			runType = 'testFile',
		},
	}, {
		type = 'scala',
		request = 'launch',
		name = 'Test target',
		metals = {
			runType = 'testTarget',
		},
	}
}


return M
