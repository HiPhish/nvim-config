-- https://github.com/teto/home/blob/98d45eb0e1663aebcec58c1b04f91fde767a5cea/config/nvim/init.lua#L8
-- https://github.com/neovim/nvim-lsp/issues/41

local nvim_lsp = require 'nvim_lsp'
local configs = require'nvim_lsp/configs'
local util = require'nvim_lsp/util'

local workspace = '~/.local/share/eclipse/workspace/' .. vim.call('fnamemodify', vim.call('getcwd'), ':t')

local pom_rp = util.root_pattern("pom.xml")
local gradle_rp = util.root_pattern("build.gradle")

configs.eclipse_jdt_ls= {
	default_config = {
		cmd = {'sh', vim.loop.os_homedir() .. '/.bin/java-lsp.sh', '-data', workspace};
		filetypes = {'java'};
		root_dir = function(fname)
			return nvim_lsp.util.find_git_ancestor(fname) or pom_rp(fname) or gradle_rp(fname) or vim.loop.os_homedir()
		end;
		log_level = vim.lsp.protocol.MessageType.Warning;
		settings = {};
	};
}

nvim_lsp.eclipse_jdt_ls.setup{}
