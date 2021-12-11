local ultest = require 'ultest'

ultest.setup {
	builders = {
		-- `cmd` is the shell command used to invoke the test runner for one
		-- particular test, e.g. {'pytest', 'test_main::test_add'}
		['python#pytest'] = function(cmd)
			-- The command can start with the name of an interpreter rather
			-- than the name of the module; in that case we need to skip ahead
			-- in the command to find the position of the actual module name
			local non_modules = {'python%d?', 'pipenv', 'poetry'}
			local module_index = 1

			for pattern in pairs(non_modules) do
				if string.match(cmd[1], pattern) then
					module_index = 3
					break
				end
			end

			local module = cmd[module_index]
			local args = vim.list_slice(cmd, module_index + 1)
			return {
				dap = {
					type = 'python',
					request = 'launch',
					module = module,
					args = args,
					console = 'internalConsole',
					justMyCode = false,
				}
			}
		end
	}
}
