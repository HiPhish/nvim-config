local nvim_lsp = require'nvim_lsp'
local util     = require'vim.lsp.util'

-- [ OVERRIDE CLIENT FUNCTIONS ] ----------------------------------------------
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


-- [ ECLIPSE.JDT.LS ] ---------------------------------------------------------
nvim_lsp.jdtls.setup(require'lsp_config.jdtls')


-- [ GODOT GAME ENGINE ] ------------------------------------------------------
nvim_lsp.gdscript.setup {
	on_attach = require'completion'.on_attach,
}
