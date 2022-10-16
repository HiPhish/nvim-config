---Settings which are relevant and useful for all language servers. Individual
---configurations can override or add to the default configuration.
local M = {}

local local_util = require 'hiphish.lsp.util'

--- Directory containing all manually installed servers.
M.server_dir = vim.fn.expand'~/Applications/lsp'

---Generate a depth-first root directory matcher
---
---The arguments are list of root directory patterns.
---
---@return function
---  For each argument first try to match its patterns before trying to match
---  the next set of patterns.
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

---Custom LSP client capabilities; this is the default extended with extra
---capabilities provided by plugins.
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
