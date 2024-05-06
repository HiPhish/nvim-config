local cmp = require 'cmp'
local conf_context = require 'cmp.config.context'
local snippy = require 'snippy'


---Whether the completion is happening outside a comment string.
---@return boolean
local function outside_comment()
	local within_treesitter_comment = conf_context.in_treesitter_capture('comment')
	local within_syntax_comment = conf_context.in_syntax_group('Comment')
	return not within_treesitter_comment and not within_syntax_comment
end

---Definitions of source specifications for reuse.
local sources = {
	snippy = {name = 'snippy'},
	path   = {name = 'path'},
	dap    = {name = 'dap'},
}


cmp.setup {
	enabled = true,
	preselect = cmp.PreselectMode.None,
	snippet = {
		expand = function(args)
			snippy.expand_snippet(args.body)
		end
	},
	window = {
		documentation = cmp.config.window.bordered(),
		completion = {
			-- border = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'},
		}
	},
	mapping = {
		['<CR>'] = cmp.mapping.confirm({select = false}),
		['<C-E>'] = cmp.mapping.abort(),
		['<C-N>'] = cmp.mapping.select_next_item(),
		['<C-P>'] = cmp.mapping.select_prev_item(),
		['<m-j>'] = cmp.mapping.scroll_docs(1),
		['<m-k>'] = cmp.mapping.scroll_docs(-1),
		['<c-Space>'] = cmp.mapping.complete {
			reason = cmp.ContextReason.Manual,
		},
	},
	sources = cmp.config.sources {
		{name = 'nvim_lsp', entry_filter = outside_comment},
		{name = 'nvim_lsp_signature_help'},
		sources.snippy,
		sources.path,
	}
}

cmp.setup.filetype({'dap-repl', 'dapui_watches', 'dapui_hover'}, {
	sources = {
		sources.dap,
	}
})

cmp.setup.filetype({'lisp'}, {
	sources = {
		{name = 'nvlime'},
		sources.snippy,
		sources.path,
	}
})

cmp.setup.filetype({'sql'}, {
	sources = {
		{name = 'vim-dadbod-completion', entry_filter = outside_comment},
		sources.snippy,
	},
})

cmp.setup.filetype({'fennel-repl'}, {
	sources = {
		{name = 'fennel-repl'}
	}
})
