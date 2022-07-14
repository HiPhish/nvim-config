-- Settings which are relevant and useful for all language servers. Individual
-- configurations can override or add to the default configuration.
local M = {}

local local_util = require'hiphish.lsp.util'
local completion_on_attach = require'completion'.on_attach

--- Directory containing all manually installed servers.
M.server_dir = vim.fn.expand'~/Applications/lsp'

--- Generate a depth-first root directory matcher
---
--- The arguments are list of root directory patterns.
---
--- @return function
---   For each argument first try to match its patterns before trying to match
---   the next set of patterns.
function M.root_patterns(...)
	local config_util = require'lspconfig.util'
	local searchers = {}

	for _, patterns in ipairs({...}) do
		local searcher = type(patterns) == 'table'
			and config_util.root_pattern(unpack(patterns))
			or config_util.root_pattern(patterns)
		searchers[#searchers + 1] = searcher
	end

	return function(startpath)
		for _, searcher in ipairs(searchers) do
			local root = searcher(startpath)
			if root then return root end
		end
	end
end
--- Default on attach function for all servers
--
-- Individual server configurations can included this one as part of their
-- callback.
function M.on_attach(client, _)
	-- Support for completion-nvim
	completion_on_attach(client)

	-- Use LSP as default formatter
	vim.api.nvim_buf_set_option(0, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')

	-- Remap keys
	local opts = {noremap = true, silent = true}
	for mode, mappings in pairs(local_util.mappings) do
		for lhs, rhs in pairs(mappings) do
			vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, opts)
		end
	end
end


M.capabilities = local_util.capabilities {
	textDocument = {
		completion = {
			completionItem = {
				snippetSupport = true
			}
		}
	}
}


return M
