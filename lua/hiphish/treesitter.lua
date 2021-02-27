require'spellsitter'.setup {
	captures = {'comment', 'string'}
}

require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,
		use_languagetree = true, -- Use this to enable language injection
		custom_captures = {  -- List of `["capture"] = "Vim HL group"` mappings
		},
	},
	incremental_selection = {
		enable = true,
	},
	indent = {
		enable = true
	}
}

local highlight_links = {
	TSPunctDelimiter = 'NONE',
	TSTagDelimiter   = 'NONE',
	TSPunctBracket   = 'NONE',
}

for key, value in pairs(highlight_links) do
    vim.cmd(string.format('highlight link %s %s', key, value))
end
