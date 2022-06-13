local success, telescope = pcall(require, 'telescope')
if not success then return end
local builtin = require 'telescope.builtin'

telescope.setup {
	defaults = {
		winblend = 30,
		border = true,
		mappings = {
			i = {
			},
			n = {
			}
		}
	},
	pickers = {
	},
	extensions = {
	}
}

vim.keymap.set('n', '<C-P>', builtin.find_files)
vim.keymap.set('n', '<C-N>', builtin.buffers)
