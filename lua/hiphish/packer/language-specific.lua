local util = require 'hiphish.packer.util'
local either = util.either

return {
	-- " Awk
	either('~/Developer/vim/awk-ward.nvim/', 'https://gitlab.com/HiPhish/awk-ward.nvim'),

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
	either('~/Developer/vim/quicklisp.nvim/', 'https://gitlab.com/HiPhish/quicklisp.nvim'),

	-- " GDScript (Godot)
	'habamax/vim-godot',

	-- " Elixir
	'elixir-editors/vim-elixir',

	-- " Fennel
	'bakpakin/fennel.vim',

	-- " GraphQL
	'jparise/vim-graphql',

	-- Jinja
	either('~/Developer/vim/jinja.vim/', 'https://gitlab.com/HiPhish/jinja.vim'),

	-- Kotlin
	'udalov/kotlin-vim',

	-- Meson
	'igankevich/mesonic',

	-- Nim
	'zah/nim.vim',

	-- Python
	'https://gitlab.com/HiPhish/pycodestyle.nvim',

	-- Racket
	{
		either('~/Developer/neovim.rkt/', 'https://gitlab.com/HiPhish/neovim.rkt'),
		rtp = 'nvim'
	},

	-- " Scheme
	either('~/Developer/vim/guile.vim', 'https://gitlab.com/HiPhish/guile.vim'),

	-- TOML
	'cespare/vim-toml',

	-- " Vala
	'arrufat/vala.vim',
}
