local nvim_lsp = require 'nvim_lsp'
local util = require 'vim.lsp.util'

---[ OVERRIDE CLIENT FUNCTIONS ]-----------------------------------------------
-- Here I override the functions of the LSP client to my liking. An override
-- should preferably still call the original function for better
-- maintainability.

-- Store original functions here for back reference. First declare the
-- function, then assign it wrapped inside a check. The purpose of this
-- roundabout way is to make sure we do not overwrite the first saved function
-- if this script gets sourced a second time.

local fancy_floating_markdown
if not fancy_floating_markdown then
	fancy_floating_markdown = util['fancy_floating_markdown']
end

-- Inject a maximum width into the window options.
util['fancy_floating_markdown'] = function (contents, opts)
	if opts['max_width'] then goto call end
	opts['max_width'] = 100  -- I could use a fancy computed value instead

	::call::
	return fancy_floating_markdown(contents, opts)
end


---[ ECLIPSE.JDT.LS ]----------------------------------------------------------

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


---[ GODOT GAME ENGINE ]-------------------------------------------------------
nvim_lsp.gdscript.setup{}
