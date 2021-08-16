local util = require 'hiphish.packer.util'

return {
	'tpope/vim-fugitive',      -- Git support
	'airblade/vim-gitgutter',  -- Git gutter symbols
	'tpope/vim-eunuch',        -- UNIX command wrapper
	'tpope/vim-commentary',    -- Commenting, uncommenting
	'tpope/vim-ragtag',        -- Complete HTML tabs
	'tpope/vim-characterize',  -- Better display of character character codes
	'nanotee/luv-vimdocs',              -- Documentation for libuv bindings
	'chrisbra/NrrwRgn',                 -- Narrowing feature
	'fmoralesc/vim-tutor-mode',         -- Interactive Vim tutorials
	'Raimondi/delimitMate',             -- Auto-insert matching braces
	'luochen1990/rainbow',              -- Differently coloured parentheses
	'bronson/vim-visual-star-search',   -- Use * on a selection to search for it
	'SirVer/ultisnips',                 -- Snippets
	'honza/vim-snippets',               -- Snippets for UltiSnips
	'guns/vim-sexp',                    -- Normal-mode motions for S-expressions
	'hoob3rt/lualine.nvim',
	'junegunn/vader.vim',               -- Testing framework
	util.either('~/Developer/vim/info.vim/', 'https://gitlab.com/HiPhish/info.vim'),
	util.either('~/Developer/vim/repl.nvim/', 'https://gitlab.com/HiPhish/repl.nvim'),
	{
		'editorconfig/editorconfig-vim',  -- Universal editor configuration files
		config = function()
			vim.g.EditorConfig_exclude_patterns = {'fugitive://.*', 'scp://.*'}
		end
	},
	{
		'Olical/conjure',
		tag = 'v4.21.0',
		config = function() vim.g['conjure#filetype#scheme'] = 'conjure.client.guile.socket' end
	}, {
		'rcarriga/vim-ultest',          -- Run tests (extras)
		requires = {'vim-test/vim-test'}
	}, {
		'lukas-reineke/indent-blankline.nvim',
		config = function()
			vim.g.indent_blankline_filetype = {'python', 'nim'}
			vim.g.blankline_enabled = true
			vim.g.indent_blankline_char = '│'
			vim.g.indent_blankline_space_char = ' '
			vim.g.indent_blankline_space_char_blankline = ' '
			vim.g.indent_blankline_show_current_context = true
			vim.g.indent_blankline_context_patterns = {
				'class', 'function', 'def', 'method', '^if', '^elif', '^else', '^for',
				'^with', '^while', '^until', '^try', '^except', '^finally'
			}
			vim.g.indent_blankline_context_highlight_list = {
				'RainbowRed', 'RainbowYellow', 'RainbowBlue', 'RainbowGreen',
				'RainbowCyan', 'RainbowOrange', 'RainbowViolet'
			}
			vim.g.indent_blankline_space_char_blankline_highlight_list = vim.g.indent_blankline_context_highlight_list
		end
	}, {
		'MarcWeber/vim-addon-local-vimrc',  -- Settings local to a given project
		config = function()
			vim.g.local_vimrc = {names = {'.vimrc', 'vimrc', 'rc.vim'}}
		end
	}, {
		'junegunn/fzf.vim',
		requires = 'junegunn/fzf',
		config = function()
			vim.g.fzf_layout = {down = '~30%'}
			vim.api.nvim_set_keymap('n', '<C-P>', ':FZF<CR>', {silent = true, noremap = true})
			vim.api.nvim_set_keymap('n', '<C-n>', ':Buffers<CR>', {silent = true, noremap = true})
		end
	}, {
		'dstein64/vim-win',
		config = function ()
			vim.g.win_resize_height = 1
			vim.g.win_resize_width = 1
			vim.g.win_ext_command_map = {
				['q'] = 'quit',
				['Q'] = 'quit!',
				['H'] = 'wincmd >',
				['J'] = 'wincmd +',
				['K'] = 'wincmd -',
				['L'] = 'wincmd <',
				['='] = 'wincmd =',
			}
		end
	}, {
		'rhysd/vim-operator-surround', -- Surround text objects
		requires = 'kana/vim-operator-user',
		config = function ()
			vim.api.nvim_set_keymap('', 'sa', '<Plug>(operator-surround-append)',  {silent = true})
			vim.api.nvim_set_keymap('', 'sd', '<Plug>(operator-surround-delete)',  {silent = true})
			vim.api.nvim_set_keymap('', 'sc', '<Plug>(operator-surround-replace)', {silent = true})
		end
	}, {
		'RRethy/vim-hexokinase',     -- Colour preview inside the text editor
		run = 'make hexokinase',
		config = function ()
			vim.g.Hexokinase_virtualText = '⬤'
			vim.g.Hexokinase_ftAutoload = {'vim', 'css', 'conf', 'zathura'}
			vim.g.Hexokinase_optInPatterns = {'full_hex', 'triple_hex', 'rgb', 'rgba'}
		end
	}, {
		'KabbAmine/vCoolor.vim',     -- Colour picker
		config = function()
			vim.g.vcoolor_disable_mappings = 1
			vim.g.vcoolor_custom_picker = 'kcolorchooser --print'
			vim.api.nvim_set_keymap('i', '<c-x><c-c>', '<c-o>:VCoolIns ra<cr>', {noremap = true})
		end
	}, {
		'preservim/nerdtree',      -- Project drawer
		config = function ()
			vim.g.NERDTreeMinimalUI = 1  -- Remove boilerplate clutter
			-- Ignore compiled files
			vim.g.NERDTreeIgnore = {'\\v\\.pyc$', '\\v\\~$', '\\v\\.meta$'}
			vim.g.NERDTreeMouseMode = 2  -- Single-click for directories
		end
	}, {
		'justinmk/vim-dirvish',    -- File system browser
		config = function ()
			vim.api.nvim_set_keymap('n', '<C-j>', ':execute "Dirvish" expand(\'%:h\')<CR>', {noremap = true, silent = true})
			-- Disable NetRW, Dirvish will take its place
			vim.g.loaded_netrw       = 1
			vim.g.loaded_netrwPlugin = 1
		end
	},
}
