-- See the following for information:
-- https://github.com/teto/home/blob/98d45eb0e1663aebcec58c1b04f91fde767a5cea/config/nvim/init.lua#L8
-- https://github.com/neovim/nvim-lsp/issues/41

local lsp = require 'vim/lsp'
local nvim_lsp = require 'nvim_lsp'
local configs = require'nvim_lsp/configs'
local util = require'nvim_lsp/util'


---[ HELPER FUNCTIONS ]--------------------------------------------------------
local function expand(expr, nosuf, list)
	return vim.call('expand', expr, nosuf, list)
end

local function root_dir(fname)
	return nvim_lsp.util.find_git_ancestor(fname)
		or util.root_pattern('build.gradle')
		or util.root_pattern('pom.xml')
		or util.root_pattern('build.xml')
		or vim.call('getcwd')
end

-- Returns the major OpenJDK version. Note that for anything prior to Java 9
-- the major version will be 1,
local function get_jdk_version()
	local output = vim.call('systemlist', {'java', '-version'})
	local jdk_version = nil
	for _, line in ipairs(output) do
		local version = line:find('version') and line:match('(%d+).%d+.%d+')
		if version then jdk_version = version break end
	end
	if jdk_version then return jdk_version + 0 else return 1 end
end


---[ PARAMETERS ]--------------------------------------------------------------
-- The following values are user-specific, there needs to be some way for the
-- user to override my hard-coded defaults.

-- Where the language server is installed to (rood directory of the server
-- package)
local install_dir = expand('~/.bin/eclipse.jdt.ls/')

-- The workspace directory is generated from the file path. This will set the
-- workspace directory when Neovim starts, rather than when the server is
-- started.
local workspace = expand('~/.local/share/eclipse/workspace/')
	.. vim.call('fnamemodify', vim.call('getcwd'), ':t')


---[ CONFIGURATION VALUES ]----------------------------------------------------
-- Hard-coded values which are not expected to change

local capabilities = lsp.protocol.make_client_capabilities()

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
	workspace
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

local config = {
	default_config = util.utf8_config {
		cmd = cmd,
		filetypes = {'java'};
		root_dir = root_dir;
		log_level = vim.lsp.protocol.MessageType.Warning;
		settings = {};
		capabilities = capabilities;
	},
	docs = {
		description = "Eclipse JDT language server"
	}
}

configs.jdt_ls = config
