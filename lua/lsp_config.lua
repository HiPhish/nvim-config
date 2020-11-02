local nvim_lsp = require'nvim_lsp'
local util     = require'vim.lsp.util'

--- [ OVERRIDE CLIENT FUNCTIONS ] ---------------------------------------------
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


--- [ COMMON CONFIGURATION ] --------------------------------------------------
-- Settings which are relevant and useful for all language servers. Individual
-- configurations can override or add to the default configuration.

local completion_on_attach = require'completion'.on_attach

--- Map keys for the current buffer
--
-- @param mode  Mode for which the mapping applies
-- @param lhs   Key or keys to map
-- @param rhs   What to map to
local function map(mode, lhs, rhs)
	local opts = {noremap = true, silent = true}
	vim.fn.nvim_buf_set_keymap(0, mode, lhs, rhs, opts)
end

--- Default on attach function for all servers
--
-- Individual server configurations can included this one as part of their
-- callback.
local function on_attach(client, bufnr)
	-- Support for completion-nvim
	completion_on_attach(client)

	-- Remap keys
	map('n', 'gd'   , '<cmd>lua vim.lsp.buf.definition()<CR>')
	map('n', 'gD'   , '<cmd>lua vim.lsp.buf.declaration()<CR>')
	map('n', 'gO'   , '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
	map('n', '<C-G>', '<cmd>lua vim.lsp.buf.references()<CR>')
	map('n', '<F2>' , '<cmd>lua vim.lsp.buf.rename()<CR>')
	map('n', 'K'    , '<cmd>lua vim.lsp.buf.hover()<CR>')
	map('n', '<CR>' , '<cmd>lua vim.lsp.buf.code_action()<CR>')
	map('n', 'g?'   , '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
end


--- [ ECLIPSE.JDT.LS ] --------------------------------------------------------
do
	local config = require'lsp_config.jdtls'
	local old_on_attach = config.on_attach
	config.on_attach = function (client, buffer)
		on_attach(client, bufnr)
		map('n', '<CR>' , '<cmd>lua require"jdtls".code_action()<CR>')
		if old_on_attach then
			old_on_attach(client, buffer)
		end
		require('jdtls').setup_dap()
	end

	nvim_lsp.jdtls.setup(config)
end


--- [ GODOT GAME ENGINE ] -----------------------------------------------------
nvim_lsp.gdscript.setup {
	on_attach = on_attach,
}


--- [ HTML ]-------------------------------------------------------------------
nvim_lsp.html.setup {
	on_attach = on_attach,
}


--- [ KOTLIN LANGUAGE SERVER ]-------------------------------------------------
do
	local util = require'nvim_lsp.util'

	-- The presence of one of these files indicates a project root directory
	local root_files = {
		'build.xml',
		'pom.xml',
		-- 'build.gradle',
		-- 'build.gradle.kts',
		'settings.gradle',
		'settings.gradle.kts',
	}

	-- The custom configuration
	local config = {
		cmd = {
			vim.loop.os_homedir()
				.. '/.cache/nvim/nvim_lsp/'
				.. 'kotlin-language-server/server/bin/kotlin-language-server',
		},
		settings = {
			kotlin = {
				compiler = {
					jvm = {
						target = '1.8'  -- Required for Spring Boot projects
					}
				}
			},
		},
    	root_dir = util.root_pattern(unpack(root_files)),
		on_attach = on_attach,
	}

	nvim_lsp.kotlin_language_server.setup(config)
end


--- [ LUA LANGUAGE SERVER ]----------------------------------------------------
do
	local config = require'lsp_config.sumneko_lua'
	config.on_attach = on_attach

	nvim_lsp.sumneko_lua.setup(config)
end


--- [ OMNISHARP ] -------------------------------------------------------------
nvim_lsp.omnisharp.setup {
	on_attach = on_attach,
}


--- [ TYPESCRIPT ]-------------------------------------------------------------
nvim_lsp.tsserver.setup {
	on_attach = on_attach,
}


--- [ VUE.JS LANGUAGE SERVER ]-------------------------------------------------
nvim_lsp.vuels.setup {
	on_attach = on_attach,
}
