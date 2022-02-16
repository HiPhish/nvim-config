local nvim_lsp   = require'lspconfig'
local util       = require'vim.lsp.util'
local local_util = require'hiphish.lsp.util'


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
	local config_util = require'lspconfig.util'
	local searchers = {}

	for _, patterns in ipairs({...}) do
		local searcher = type(patterns) == 'table'
			and config_util.root_pattern(unpack(patterns))
			or config_util.root_pattern(patterns)
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

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
	vim.lsp.handlers.hover, {
		border = 'rounded',  -- See `:h nvim_open_win()`
	}
)

--- [ COMMON CONFIGURATION ] --------------------------------------------------
-- Settings which are relevant and useful for all language servers. Individual
-- configurations can override or add to the default configuration.

local completion_on_attach = require'completion'.on_attach

--- Default on attach function for all servers
--
-- Individual server configurations can included this one as part of their
-- callback.
local function on_attach(client, _)
	-- Support for completion-nvim
	completion_on_attach(client)

	-- Use LSP as default formatter
	vim.api.nvim_buf_set_option(0, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')

	-- Remap keys
	local opts = {noremap = true, silent = true}
	for mode, mappings in pairs(local_util.mappings) do
		for lhs, rhs in pairs(mappings) do
			vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, opts)
		end
	end
end


local capabilities = local_util.capabilities {
	textDocument = {
		completion = {
			completionItem = {
				snippetSupport = true
			}
		}
	}
}


--- [ Angular ]----------------------------------------------------------------
nvim_lsp.angularls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}


--- [ CLANGD ]-----------------------------------------------------------------
nvim_lsp.clangd.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}



--- [ DOCKERFILE LS NODEJS ]---------------------------------------------------
nvim_lsp.dockerls.setup {
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
		vim.api.nvim_buf_set_keymap(0, 'n', '<CR>', '<cmd>lua require"jdtls".code_action()<CR>', {noremap = true, silent = true})
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


--- [ ERLANG_LS ]--------------------------------------------------------------
nvim_lsp.erlangls.setup {
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
	cmd = {vim.fn.expand '~/.nimble/bin/nimlsp'},
	on_attach = on_attach,
	capabilities = capabilities,
}


--- [ OMNISHARP ] -------------------------------------------------------------
-- Requires system Mono, bypass the included `run` script and launch the
-- EXE directory instead
nvim_lsp.omnisharp.setup {
	cmd = {
		'mono',
		server_dir .. '/omnisharp-linux-x64/omnisharp/OmniSharp.exe',
		'--languageserver',
		'--hostPID', tostring(vim.fn.getpid()),
	},
	on_attach = on_attach,
	capabilities = capabilities,
}


--- [ PYLSP ]------------------------------------------------------------------
nvim_lsp.pylsp.setup {
	cmd = {
		vim.fn.executable('pylsp') ~= 0
			and 'pylsp'
			or vim.env.HOME .. '/.local/bin/pylsp'
	},
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		pylsp = {
			plugins = {
				['pylsp-mypy'] = {
					enabled = true,
				},
			}
		}
	},
}


--- [ METALS ]-----------------------------------------------------------------
-- Metals has a lot of extension to the protocol, so we use a dedicated plugin
-- for it. If the plugin is not installed we fall back to regular Neovim
-- configuration.

do
	local success = pcall(function() require 'hiphish.lsp.metals' end)

	if not success then
		nvim_lsp.metals.setup {
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				metals = {
					javaHome = vim.fn.environ()['JAVA_HOME'],
				},
			},
		}
	end
end


--- [ TYPESCRIPT ]-------------------------------------------------------------
nvim_lsp.tsserver.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}


--- [ VALA LANGUAGE SERVER ] --------------------------------------------------
nvim_lsp.vala_ls.setup {
	cmd = {server_dir .. '/vala-language-server/build/src/vala-language-server'},
	on_attach = on_attach,
	capabilities = capabilities,
	-- Workaround for projects with multiple build files
	root_dir = function(fname)
      return (vim.fn.filereadable('meson.build') and vim.fn.getcwd())
      	or nvim_lsp.vala_ls.document_config.default_config.root_dir(fname)
	end
}


--- [ VUE.JS LANGUAGE SERVER ]-------------------------------------------------
nvim_lsp.vuels.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
