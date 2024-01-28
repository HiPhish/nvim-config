-- Context comment string
-- See |ts-context-commentstring.txt|
vim.g.skip_ts_context_commentstring_module = true


require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,
		use_languagetree = true, -- Use this to enable language injection
		custom_captures = {
			-- List of `["capture"] = "Vim HL group"` mappings
		},
	},
	incremental_selection = {
		enable = true,
	},
	indent = {
		enable = true,
		disable = {'python', 'yaml'},
	},
	matchup = {
		enable = true,
		disable = {},
	},
	-- I want to be able to set mappings per file type, but the textobject
	-- plugin does not support that. I should look for a better tree
	-- manipulation plugin instead.
	textobjects = {
		swap = {
			enable = true,
			swap_next = {
				['<m-l>'] = '@SExpr',
			},
			swap_previous = {
				['<m-h>'] = '@SExpr',
			}
		}
	}
}

do  -- Fix spell checking
	local success, spellsitter = pcall(require, 'spellsitter')
	if success then
		spellsitter.setup {
			captures = {'comment', 'string'}
		}
	end
end
