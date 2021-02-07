--- My own eclipse.jdt.ls overrides
--
-- These are my personal overrides for the official Java language server
-- settings. I should contribute them upstream when I find them mature enough.
-- Some of the configuration uses a plugin which provides additional
-- functionality on top of what the protocol supports.
--
-- https://github.com/mfussenegger/nvim-jdtls

local jdtls = require'jdtls'
local api   = vim.api


-- [ CONFIGURATION TABLE ] ----------------------------------------------------
-- Here is where the additional settings from the jdtls plugin are added.

local default = require'lspconfig'.jdtls.document_config.default_config

local handlers = {
	-- The server sends a non-standard 'language/status' notification to inform
	-- the client about the current status of the server. This is usually used
	-- while starting up the server.
	['language/status'] = vim.schedule_wrap(function(_, _, result)
		api.nvim_command(string.format(':echohl ModeMsg | echo "%s" | echohl None', result.message))
	end)
}

local init_options = {
	extendedClientCapabilities = jdtls.extendedClientCapabilities,
	bundles = {
		vim.fn.glob("~/.cache/nvim/nvim-dap/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"),
	},
}

-- The workspace directory is generated from the file path. This will set the
-- workspace directory when Neovim starts, rather than when the server is
-- started.
local workspace = vim.fn.expand('~/.local/share/eclipse/workspace/')
	.. vim.call('fnamemodify', vim.call('getcwd'), ':t')
local capabilities = vim.lsp.protocol.make_client_capabilities()

local config = {
	cmd = {
		'java',
		'-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044',
		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.level=ALL',
		'-noverify',
		'-Xmx1G',
		'-jar', vim.fn.glob('~/Applications/lsp/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
		'-configuration', vim.fn.glob('~/Applications/lsp/jdtls/config_linux'),
		'-data', workspace,
		'--add-modules=ALL-SYSTEM',
		'--add-opens', 'java.base/java.util=ALL-UNNAMED',
		'--add-opens', 'java.base/java.lang=ALL-UNNAMED'
	},
	workspace = workspace,
	capabilities = vim.tbl_extend('keep', capabilities, default.capabilities or {}),
	init_options = vim.tbl_extend('keep', init_options, default.init_options or {}),
	log_level = vim.lsp.protocol.MessageType.Warning,
	handlers = vim.tbl_extend('keep', default.handlers or {}, handlers),
}

-- Override some of the configuration settings
config.capabilities.textDocument.codeAction = {
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
config.init_options.extendedClientCapabilities.classFileContentsSupport = true


-------------------------------------------------------------------------------
return config
