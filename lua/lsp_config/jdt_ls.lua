-- See the following for information:
-- https://github.com/teto/home/blob/98d45eb0e1663aebcec58c1b04f91fde767a5cea/config/nvim/init.lua#L8
-- https://github.com/neovim/nvim-lsp/issues/41

local lsp = require 'vim/lsp'
local nvim_lsp = require 'nvim_lsp'
local configs = require'nvim_lsp/configs'
local util = require'nvim_lsp/util'

local capabilities = lsp.protocol.make_client_capabilities()

-- The workspace directory is generated from the file path
local workspace = '~/.local/share/eclipse/workspace/' .. vim.call('fnamemodify', vim.call('getcwd'), ':t')

local function root_dir(fname)
	return nvim_lsp.util.find_git_ancestor(fname)
		or util.root_pattern("build.gradle")
		or util.root_pattern("pom.xml")
		or util.root_pattern("build.xml")
		or vim.call('getcwd')
end

local config = {
	default_config = util.utf8_config {
		cmd = {'sh', vim.loop.os_homedir() .. '/.bin/java-lsp.sh', '-data', workspace};
		filetypes = {'java'};
		root_dir = root_dir;
		log_level = vim.lsp.protocol.MessageType.Warning;
		settings = {};
		capabilities = capabilities;
	};
}

configs.eclipse_jdt_ls = config
