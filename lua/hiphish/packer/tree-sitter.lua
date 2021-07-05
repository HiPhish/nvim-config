return {
	{
		'nvim-treesitter/nvim-treesitter',
		run = function() vim.api.nvim_command 'TSUpdate' end
	}, {
		'nvim-treesitter/playground',
		'lewis6991/spellsitter.nvim',
		requires = 'nvim-treesitter/nvim-treesitter'
	},
}
