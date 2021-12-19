local dap     = require 'dap'
local debugpy = require 'debugpy'

local default_config = {
	justMyCode = false,
}

debugpy.run = function(config)
	-- Extend the configuration with my personal defaults
	dap.run(vim.tbl_extend('keep', config, default_config))
end

