local dap = require 'dap'

--- Adapter configuration
dap.adapters.kotlin_da = {
	type = 'executable',
	command = vim.fn.stdpath('cache')
		.. '/nvim-dap/kotlin-debug-adapter/adapter/bin/kotlin-debug-adapter',
	args = {}
}

local M = {}
local last_config

local function configure(main_class, project_root)
	if not main_class then
		if not last_config then
			return
		end
		return last_config
	end

	local config = {
		type = kotlin,
		request = 'launch',
		name = main_class
		mainClass = main_class,
		projectRoot = project_root or vim.fn.getcwd(),
	}

	last_config = config
	return config
end

function M.start(args)
	local config = configure(unpack(args))
	if not config then
		-- TODO: display error
		return
	end

	dap.run(config)
	dap.repl.open()
end

vim.cmd [[
    command! -complete=file -nargs=* DebugKotlin lua require "dap_config.kotlin".start({<f-args>})
]]

return M
