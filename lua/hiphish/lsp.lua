local nvim_lsp = require'lspconfig'
local util     = require'vim.lsp.util'

--- [ HELPER FUNCTIONS ] ------------------------------------------------------

--- Directory containing all manually installed servers.
local server_dir = vim.fn.expand'~/Applications/lsp'

--- Generate a depth-first root directory matcher
---
--- The arguments are list of root directory patterns.
---
--- @return function
---   For each argument first try to match its patterns before trying to match
---   the next set of patterns.
local function root_patterns(...)
	local util = require'lspconfig.util'
	local searchers = {}

	for _, patterns in ipairs({...}) do
		local searcher = type(patterns) == 'table'
			and util.root_pattern(unpack(patterns))
			or util.root_pattern(patterns)
		searchers[#searchers + 1] = searcher
	end

	return function(startpath)
		for _, searcher in ipairs(searchers) do
			local root = searcher(startpath)
			if root then return root end
		end
	end
end


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

-- local completion_on_attach = require'completion'.on_attach

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
local function on_attach(client, _)
	-- Support for completion-nvim
	-- completion_on_attach(client)

	-- Remap keys
	map('n', 'gd'   , '<cmd>lua vim.lsp.buf.definition()<CR>')
	map('n', 'gD'   , '<cmd>lua vim.lsp.buf.declaration()<CR>')
	map('n', 'gO'   , '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
	map('n', '<C-G>', '<cmd>lua vim.lsp.buf.references()<CR>')
	map('n', '<F2>' , '<cmd>lua vim.lsp.buf.rename()<CR>')
	map('n', 'K'    , '<cmd>lua vim.lsp.buf.hover()<CR>')
	map('n', '<CR>' , '<cmd>lua vim.lsp.buf.code_action()<CR>')
	map('n', 'g?'   , '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

--- [ CLANGD ]-----------------------------------------------------------------
nvim_lsp.clangd.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}

--- [ ECLIPSE.JDT.LS ] --------------------------------------------------------
do
	local root_files = {
		{'build.xml', 'settings.gradle', 'settings.gradle.kts'},
		{'pom.xml', 'build.gradle', 'build.gradle.kts'},
	}

	local config = require'hiphish.lsp.jdtls'
	local old_on_attach = config.on_attach

	config.root_dir = root_patterns(unpack(root_files))

	config.on_attach = function (client, bufnr)
		on_attach(client, bufnr)
		map('n', '<CR>' , '<cmd>lua require"jdtls".code_action()<CR>')
		if old_on_attach then
			old_on_attach(client, bufnr)
		end
		require('jdtls').setup_dap()
	end

	config.capabilities.textDocument.completion.completionItem.snippetSupport = true

	nvim_lsp.jdtls.setup(config)
end


--- [ ELIXIR LS ]--------------------------------------------------------------
nvim_lsp.elixirls.setup {
	cmd = {
		server_dir .. '/elixir-ls/release/language_server.sh'
	},
	capabilities = capabilities,
	on_attach = on_attach
}


--- [ GODOT GAME ENGINE ] -----------------------------------------------------
nvim_lsp.gdscript.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}


--- [ GRAPH QL ] --------------------------------------------------------------
-- For configuration see https://graphql-config.com/introduction
do
	local config_files = {
		'.git', '.graphqlrc',
		'.graphqlrc.yml', '.graphqlrc.yaml',
		'graphql.config.json', '.graphqlrc.json',
		'graphql.config.toml', '.graphqlrc.toml',
		'graphql.config.js', '.graphqlrc.js',
		'graphql.config.ts', '.graphqlrc.ts',
	}

	nvim_lsp.graphql.setup {
		on_attach = on_attach,
		capabilities = capabilities,
		root_dir = require'lspconfig.util'
			.root_pattern(unpack(config_files))
	}
end


--- [ GROOVY ]-----------------------------------------------------------------
do
	local status, _ = pcall(require, 'nvim_lsp.groovy')
	if status then
		nvim_lsp.groovy.setup {
			on_attach = on_attach,
			capabilities = capabilities,
		}
	end
end


--- [ HTML ]-------------------------------------------------------------------
nvim_lsp.html.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}


--- [ KOTLIN LANGUAGE SERVER ]-------------------------------------------------
do
	local root_files = {
		{'build.xml', 'settings.gradle', 'settings.gradle.kts'},
		{'pom.xml', 'build.gradle', 'build.gradle.kts'},
	}


	nvim_lsp.kotlin_language_server.setup{
		cmd = {
			server_dir .. '/kotlin-language-server/server/bin/kotlin-language-server',
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
    	root_dir = root_patterns(unpack(root_files)),
		on_attach = on_attach,
		capabilities = capabilities,
	}
end


--- [ LUA LANGUAGE SERVER ]----------------------------------------------------
do
	local config = require'hiphish.lsp.sumneko_lua'
	config.on_attach = on_attach
	config.capabilities = capabilities

	nvim_lsp.sumneko_lua.setup(config)
end


--- [ Nim LS ] ----------------------------------------------------------------
nvim_lsp.nimls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}


--- [ OMNISHARP ] -------------------------------------------------------------
nvim_lsp.omnisharp.setup {
	cmd = {
		server_dir .. '/omnisharp/run',
		'--hostPID', tostring(vim.fn.getpid()),
		'--languageserver'
	},
	on_attach = on_attach,
	capabilities = capabilities,
}


--- [ PYLS ]-------------------------------------------------------------------
nvim_lsp.pyls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}


--- [ TYPESCRIPT ]-------------------------------------------------------------
nvim_lsp.tsserver.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}


--- [ VUE.JS LANGUAGE SERVER ]-------------------------------------------------
nvim_lsp.vuels.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
