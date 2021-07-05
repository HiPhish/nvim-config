local util = require 'hiphish.packer.util'

return {
	-- " Awk
	util.either('~/Developer/vim/awk-ward.nvim/', 'https://gitlab.com/HiPhish/awk-ward.nvim'),

	-- " Common Lisp
	{
		'adolenc/cl-neovim',
		config = function ()
			-- " My quicklisp is installed to a non-standard location
			vim.g.lisp_host_quicklisp_setup = '~/.local/share/quicklisp/setup.lisp'
		end
	}, {
		'l04m33/vlime',
		rtp = 'vim',
		config = function()
			vim.api.nvim_command('au BufReadPost,BufNewFile vlime* setlocal nonumber nospell')
		end
	},
	'~/Developer/vim/quicklisp.nvim/',

	-- " GDScript (Godot)
	'habamax/vim-godot',

	-- " Elixir
	'elixir-editors/vim-elixir',

	-- " Fennel
	'bakpakin/fennel.vim',

	-- " GraphQL
	'jparise/vim-graphql',

	-- Jinja
	'~/Developer/vim/jinja.vim/',

	-- Kotlin
	'udalov/kotlin-vim',

	-- Meson
	'igankevich/mesonic',

	-- Nim
	'zah/nim.vim',

	-- Racket
	{
		util.either('~/Developer/neovim.rkt/', 'https://gitlab.com/HiPhish/neovim.rkt'),
		rtp = 'nvim'
	},

	-- " Scheme
	util.either('~/Developer/vim/guile.vim', 'https://gitlab.com/HiPhish/guile.vim'),

	-- " Vala
	'arrufat/vala.vim',
}
