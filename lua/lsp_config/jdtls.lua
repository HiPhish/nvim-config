--- My own eclipse.jdt.ls overrides
--
-- These are my personal overrides for the official Java language server
-- settings. I should contribute them upstream when I find them mature enough.
-- Some of the configuration uses a plugin which provides additional
-- functionality on top of what the protocol supports.
--
-- https://github.com/mfussenegger/nvim-jdtls

local util  = require'lspconfig'.util
local jdtls = require'jdtls'
local api   = vim.api


---[ HELPER FUNCTIONS ]--------------------------------------------------------
-- For internal use, not exported

local function expand(expr, nosuf, list)
	return vim.call('expand', expr, nosuf, list)
end


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

local capabilities = vim.lsp.protocol.make_client_capabilities()

local config = {
	-- The workspace directory is generated from the file path. This will set
	-- the workspace directory when Neovim starts, rather than when the server
	-- is started.
	workspace = expand('~/.local/share/eclipse/workspace/')
		.. vim.call('fnamemodify', vim.call('getcwd'), ':t'),
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
