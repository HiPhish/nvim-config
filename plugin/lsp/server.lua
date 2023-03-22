-- This file contains all the LSP server configurations


local nvim_lsp = require'lspconfig'
local defaults = require 'hiphish.lsp.defaults'

--- Directory containing all manually installed servers.
local server_dir = defaults.server_dir
local root_patterns = defaults.root_patterns

--- [ Angular ]----------------------------------------------------------------
nvim_lsp.angularls.setup {
	capabilities = defaults.capabilities,
}


--- [ CLANGD ]-----------------------------------------------------------------
nvim_lsp.clangd.setup {
	capabilities = defaults.capabilities,
}


--- [ DOCKERFILE LS NODEJS ]---------------------------------------------------
nvim_lsp.dockerls.setup {
	capabilities = defaults.capabilities,
}


--- [ ECLIPSE.JDT.LS ] --------------------------------------------------------
do
	local jdtls = require 'jdtls'
	local root_files = {
		{'build.xml', 'settings.gradle', 'settings.gradle.kts'},
		{'pom.xml', 'build.gradle', 'build.gradle.kts'},
	}

	local config = require'hiphish.lsp.jdtls'
	local old_on_attach = config.on_attach

	config.root_dir = root_patterns(unpack(root_files))

	config.on_attach = function (client, bufnr)
		local opts = {noremap = true, silent = true, buffer = true}
		vim.keymap.set('n', '<CR>', jdtls.code_action, opts)
		if old_on_attach then
			old_on_attach(client, bufnr)
		end
		jdtls.setup_dap()
	end

	config.capabilities.textDocument.completion.completionItem.snippetSupport = true

	nvim_lsp.jdtls.setup(config)
end


--- [ ELIXIR LS ]--------------------------------------------------------------
nvim_lsp.elixirls.setup {
	cmd = {
		server_dir .. '/elixir-ls/release/language_server.sh'
	},
	capabilities = defaults.capabilities,
}


--- [ ERLANG_LS ]--------------------------------------------------------------
nvim_lsp.erlangls.setup {
	capabilities = defaults.capabilities,
}


--- [ GODOT GAME ENGINE ] -----------------------------------------------------
nvim_lsp.gdscript.setup {
	capabilities = defaults.capabilities,
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
		capabilities = defaults.capabilities,
		root_dir = require'lspconfig.util'
			.root_pattern(unpack(config_files))
	}
end


--- [ GROOVY ]-----------------------------------------------------------------
do
	local status, _ = pcall(require, 'nvim_lsp.groovy')
	if status then
		nvim_lsp.groovy.setup {
			capabilities = defaults.capabilities,
		}
	end
end


--- [ HTML ]-------------------------------------------------------------------
nvim_lsp.html.setup {
	capabilities = defaults.capabilities,
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
		capabilities = defaults.capabilities,
	}
end


--- [ LUA LANGUAGE SERVER ]----------------------------------------------------
do
	local config = require 'hiphish.lsp.lua_ls'
	config.capabilities = defaults.capabilities

	nvim_lsp.lua_ls.setup(config)
end


--- [ Nim LS ] ----------------------------------------------------------------
nvim_lsp.nimls.setup {
	cmd = {vim.fn.expand '~/.nimble/bin/nimlsp'},
	capabilities = defaults.capabilities,
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
	capabilities = defaults.capabilities,
}


--- [ METALS ]-----------------------------------------------------------------
-- Metals has a lot of extension to the protocol, so we use a dedicated plugin
-- for it. If the plugin is not installed we fall back to regular Neovim
-- configuration.

do
	local success = pcall(function() require 'hiphish.lsp.metals' end)

	if not success then
		nvim_lsp.metals.setup {
			capabilities = defaults.capabilities,
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
	capabilities = defaults.capabilities,
}


--- [ VALA LANGUAGE SERVER ] --------------------------------------------------
nvim_lsp.vala_ls.setup {
	cmd = {server_dir .. '/vala-language-server/build/src/vala-language-server'},
	capabilities = defaults.capabilities,
	-- Workaround for projects with multiple build files
	root_dir = function(fname)
      return (vim.fn.filereadable('meson.build') and vim.fn.getcwd())
      	or nvim_lsp.vala_ls.document_config.default_config.root_dir(fname)
	end
}


--- [ VUE.JS LANGUAGE SERVER ]-------------------------------------------------
nvim_lsp.vuels.setup {
	capabilities = defaults.capabilities,
}
