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
		'https://gitlab.com/HiPhish/resolarized.nvim',
		config = function()
			vim.o.background = 'dark'
			vim.cmd 'colorscheme solarized-dark'
		end
	}
}


return require('packer').startup{
	plugins
}
