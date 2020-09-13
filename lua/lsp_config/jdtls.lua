--- My own eclipse.jdt.ls overrides
--
-- These are my personal overrides for the official Java language server
-- settings. I should contribute them upstream when I find them mature enough.
-- Some of the configuration uses a plugin which provides additional
-- functionality on top of what the protocol supports.
--
-- https://github.com/mfussenegger/nvim-jdtls

local lsp      = require'vim/lsp'
local nvim_lsp = require'nvim_lsp'
local util     = require'nvim_lsp/util'
local jdtls    = require'jdtls'
local api      = vim.api


---[ HELPER FUNCTIONS ]--------------------------------------------------------
-- For internal use, not exported

local function expand(expr, nosuf, list)
	return vim.call('expand', expr, nosuf, list)
end

--- Determine the current Java version.
--
-- @return
--   The major OpenJDK version. Note that for anything prior to Java 9 the
--   major version will be 1.
local function get_jdk_version()
	local output = vim.call('systemlist', {'java', '-version'})
	local jdk_version = nil
	for _, line in ipairs(output) do
		local version = line:find('version') and line:match('(%d+).%d+.%d+')
		if version then jdk_version = version break end
	end
	if jdk_version then return jdk_version + 0 else return 1 end
end

-- This is a leftover from my old configuration where I specified the Java
-- command myself. I am keeping it around because there might still be
-- something useful to learn from it, but it is not actively used.

-- Where the language server is installed to (rood directory of the server
-- package)
local install_dir = expand('~/.bin/eclipse.jdt.ls/')

local cmd = {
	'java',
	'-Declipse.application=org.eclipse.jdt.ls.core.id1',
	'-Dosgi.bundles.defaultStartLevel=4',
	'-Declipse.product=org.eclipse.jdt.ls.core.product',
	'-Dlog.level=ALL',
	'-noverify',
	'-Xmx1G',
	'-jar',
	expand(install_dir .. 'plugins/org.eclipse.equinox.launcher_1.*.jar'),
	'-configuration',
	install_dir .. 'config_linux',
	'-data',
	workspace,
}

if get_jdk_version() > 1 then
	local extra_options = {
		'--add-modules=ALL-SYSTEM',
		'--add-opens',
		'java.base/java.util=ALL-UNNAMED',
		'--add-opens',
		'java.base/java.lang=ALL-UNNAMED'
	}
	for _, option in ipairs(extra_options) do
		cmd[#cmd+1] = option
	end
end

-- [ EXPORTED FUNCTIONS ] -----------------------------------------------------
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
	return util.find_git_ancestor(fname)
		or util.root_pattern('build.gradle', 'pom.xml', 'build.xml')(fname)
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

local default = require'nvim_lsp'.jdtls.document_config.default_config

local callbacks = {
	['language/status'] = status_callback
}

local init_options = {
	extendedClientCapabilities = jdtls.extendedClientCapabilities;
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

local config = {
	workspace = workspace,
	capabilities = vim.tbl_extend('keep', capabilities, default.capabilities or {}),
	init_options = vim.tbl_extend('keep', init_options, default.init_options or {}),
	log_level = vim.lsp.protocol.MessageType.Warning,
	callbacks = vim.tbl_extend('keep', default.callbacks or {}, callbacks),
	on_attach = require'completion'.on_attach,
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
