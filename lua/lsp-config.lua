local nvim_lsp = require 'nvim_lsp'

-- Load the server configuration into the global table as a side effect
require 'lsp_config/jdt_ls'

-- Extra settings for eclipse.jdt.ls
local jdt_ls_extra = require 'jdtls'

local jdt_ls_config = {
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	init_options = {
		extendedClientCapabilities = require('jdtls').extendedClientCapabilities
	},
	on_attach = require'completion'.on_attach,
}

-- Override some of the configuration settings
jdt_ls_config.capabilities.textDocument.codeAction = {
	dynamicRegistration = false;
	codeActionLiteralSupport = {
		codeActionKind = {
			valueSet = {
				"source.generate.toString",
				"source.generate.hashCodeEquals"
			};
		};
	};
}

-- Workaround: disable this feature until it gets fixed
jdt_ls_config.init_options.extendedClientCapabilities.classFileContentsSupport = false


nvim_lsp.jdt_ls.setup(jdt_ls_config)
