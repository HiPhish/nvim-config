local debugpy = require 'debugpy'

local default_config = {
	justMyCode = false,
	django = true;
	cwd = vim.fn.getcwd(),
}

local old_run = debugpy.run

debugpy.run = function(config)
	-- Extend the configuration with my personal defaults
	old_run(vim.tbl_extend('keep', config, default_config))
end
