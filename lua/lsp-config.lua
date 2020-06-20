local nvim_lsp = require 'nvim_lsp'
local ncm2 = require 'ncm2'


-- Load the server configuration into the global table as a side effect
require 'lsp_config.jdt_ls'


-- Set up the servers in use
nvim_lsp.eclipse_jdt_ls.setup {
	on_init = ncm2.register_lsp_source
}
