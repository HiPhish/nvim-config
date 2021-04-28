local M = {}

local metals = require 'metals'
local util = require'hiphish.lsp.util'

local config = {
	settings = {
		showImplicitArguments = true,
		showImplicitConversionsAndClasses = true,
		showInferredType = true,
	},
	capabilities = util.capabilities {
		textDocument = {
			completion = {
				completionItem = {
					snippetSupport = true
				}
			}
		}
	},
	on_attach = function(client, bufnr)
		-- Support for completion-nvim
		require'completion'.on_attach(client)

		-- Remap keys
		local opts = {noremap = true, silent = true}
		for mode, mappings in pairs(util.mappings) do
			for lhs, rhs in pairs(mappings) do
				vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
			end
		end
	end
}

--- This function is meant to be called from Scala or sbt buffers.
function M.init_or_attach()
	metals.initialize_or_attach(vim.tbl_extend('force', metals.bare_config, config))
end


if vim.fn.executable('metals') then
	vim.g.metals_use_global_executable = true
end

return M
