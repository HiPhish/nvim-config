return {
	{'mfussenegger/nvim-dap', as = 'nvim-dap'},
	{
		'mfussenegger/nvim-dap-python',
		'rcarriga/nvim-dap-ui',
		{
			'theHamsta/nvim-dap-virtual-text',
			config = function() vim.g.dap_virtual_text = true end
		},
		requires = 'nvim-dap'
	},
}
