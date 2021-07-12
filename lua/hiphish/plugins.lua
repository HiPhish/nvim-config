local plugins = {
    -- Packer managers itself
    'wbthomason/packer.nvim',

	require 'hiphish.packer.auto-completion',
	require 'hiphish.packer.lsp',
	require 'hiphish.packer.dap',
	require 'hiphish.packer.tree-sitter',
	require 'hiphish.packer.general',
	require 'hiphish.packer.language-specific',

	-- Colour schemes
	{
		'lifepillar/vim-solarized8',
		config = function()
			vim.api.nvim_command('colorscheme solarized8')
		end
	},
	'PascalZh/NeoSolarized',
}


return require('packer').startup{
	plugins
}
