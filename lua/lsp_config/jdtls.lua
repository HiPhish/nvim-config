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


--- [ EXPORTED FUNCTIONS ]-----------------------------------------------------
-- These functions will be used in the configuration

--- Root directory detection.
--
-- Attempts to find the root directory of the project based on the current
-- file name. Takes into account the popular Java build systems.
--
-- @return
--   A function of zero arguments (a thunk) which will return the path to the
--   root directory.
local function root_dir(fname)
	local root_files = {
		'pom.xml',                                 -- Ant
		'build.xml',                               -- Maven
		'settings.gradle', 'settings.gradle.kts',  -- Gradle, multi-project
		'build.gradle', 'build.gradle.kts'         -- Gradle, single project
	}
	return util.find_git_ancestor(fname)
		or util.root_pattern(unpack(root_files))(fname)
		or vim.call('getcwd')
end

--- Callback which responds to language server status notifications.
--
-- The server sends a non-standard 'language/status' notification to inform the
-- client about the current status of the server. This is usually used while
-- starting up the server.
local status_callback = vim.schedule_wrap(function(_, _, result)
	api.nvim_command(string.format(':echohl ModeMsg | echo "%s" | echohl None', result.message))
end)

-- The workspace directory is generated from the file path. This will set the
-- workspace directory when Neovim starts, rather than when the server is
-- started.
local workspace = expand('~/.local/share/eclipse/workspace/')
	.. vim.call('fnamemodify', vim.call('getcwd'), ':t')


-- [ CONFIGURATION TABLE ] ----------------------------------------------------
-- Here is where the additional settings from the jdtls plugin are added.

local default = require'lspconfig'.jdtls.document_config.default_config

local handlers = {
	['language/status'] = status_callback
}

local init_options = {
	extendedClientCapabilities = jdtls.extendedClientCapabilities,
	bundles = {
		vim.fn.glob("~/.cache/nvim/nvim-dap/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"),
	},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

local config = {
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
