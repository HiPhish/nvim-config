local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'

configs.vala_ls = {
	default_config = {
		cmd = {'vala-language-server'},
		filetypes = {'vala', 'genie'},
		root_dir = function(fname)
			return util.find_git_ancestor(fname) or  util.path.dirname(fname)
		end,
	}
}
