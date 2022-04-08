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
		enable = true
	},
	context_commentstring = {
		enable = true,
		disable = {'python', 'yaml'},
	},
	playground = {
	},
	rainbow = {
		enable = true,
		extended_mode = true,
	}
}

-- Link my own highlights to the ones from the plugin
vim.cmd 'hi link rainbowcol1 RainbowRed'
vim.cmd 'hi link rainbowcol2 RainbowYellow'
vim.cmd 'hi link rainbowcol3 RainbowBlue'
vim.cmd 'hi link rainbowcol4 RainbowGreen'
vim.cmd 'hi link rainbowcol5 RainbowOrange'
vim.cmd 'hi link rainbowcol6 RainbowCyan'
vim.cmd 'hi link rainbowcol7 RainbowViolet'

do  -- Fix spell checking
	local success, spellsitter = pcall(require, 'spellsitter')
	if success then
		spellsitter.setup {
			captures = {'comment', 'string'}
		}
	end
end

local highlight_links = {
	TSPunctDelimiter = 'NONE',
	TSTagDelimiter   = 'NONE',
	TSPunctBracket   = 'NONE',
}

for key, value in pairs(highlight_links) do
	vim.cmd(string.format('highlight link %s %s', key, value))
end
