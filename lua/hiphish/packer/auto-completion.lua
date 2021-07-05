local util = require 'hiphish.packer.util'

return {
	{
		'nvim-lua/completion-nvim',
		as = 'completion-nvim',
		requires = {'SirVer/ultisnips'},
		config = function()
			local set_keymap = vim.api.nvim_set_keymap
			vim.o.completeopt = 'menuone,noinsert,noselect'
			vim.api.nvim_exec([[
augroup completion
autocmd!
autocmd BufEnter * lua require'completion'.on_attach() 
augroup END
			]], false)
			vim.g.completion_enable_snippet = 'UltiSnips'
			vim.g.completion_enable_auto_paren = true
			vim.g.completion_trigger_on_delete = true
			vim.g.completion_auto_change_source = 1
			vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
			vim.g.completion_chain_complete_list = {
				default = {
					{complete_items = {'snippet', 'lsp', 'path'}},
					{mode = 'keyp'},
					{mode = 'keyn'},
				},
				lisp = {
			  	  {complete_items = {'snippet', 'vlime', 'path'}},
			  	  {mode = 'keyp'},
			  	  {mode = 'keyn'},
				},
				['dap-repl'] = {
			  	  {mode = 'omni'},
			  	  {mode = 'keyp'},
			  	  {mode = 'keyn'},
				},
			}
			set_keymap('i', '<C-j>', 'vsnip#available(1)  ? "<Plug>(vsnip-jump-next)" : "<C-j>"', {expr = true})
			set_keymap('s', '<C-j>', 'vsnip#available(1)  ? "<Plug>(vsnip-jump-next)" : "<C-j>"', {expr = true})
			set_keymap('i', '<C-k>', 'vsnip#available(-1) ? "<Plug>(vsnip-jump-prev)" : "<C-k>"', {expr = true})
			set_keymap('s', '<C-k>', 'vsnip#available(-1) ? "<Plug>(vsnip-jump-prev)" : "<C-k>"', {expr = true})
		end
	}, {
		'hrsh7th/vim-vsnip',
		'hrsh7th/vim-vsnip-integ',
		util.either(
			'~/Developer/vim/completion-nvim-vlime/',
			'https://gitlab.com/HiPhish/completion-nvim-vlime'
		),
		requires = {'completion-nvim'}
	},
}

