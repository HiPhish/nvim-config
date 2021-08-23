return {
	{
		'nvim-treesitter/nvim-treesitter',
		run = function() vim.api.nvim_command 'TSUpdate' end
	}, {
		'nvim-treesitter/playground',
		'lewis6991/spellsitter.nvim',
		{
			'SmiteshP/nvim-gps',
			config = function()
				require('nvim-gps').setup {
					icons = {
						['class-name'] = '',
						['function-name'] = '',
						['method-name'] = '',
					},
					languages = {
						lua = true,
						python = true,
						java = false,
					},
					separator = ' ╱ ',
				}
			end
		},
		requires = 'nvim-treesitter/nvim-treesitter'
	},
}
