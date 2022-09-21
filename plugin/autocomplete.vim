" Settings for [completion-nvim](https://github.com/nvim-lua/completion-nvim)

set completeopt=menuone,noinsert,noselect

" Telescope has problems with completion frameworks, so we need to exclude it
function! s:on_attach()
	if '\v^Telescope.*' =~# &ft 
		return
	endif
	lua require('completion').on_attach()
endfunction

augroup completion
	autocmd!
	autocmd BufEnter * call s:on_attach()
	" autocmd BufEnter *\(Telescope.*\)\@<! lua require('completion').on_attach()
augroup END


let g:completion_enable_snippet = 'snippy'
let g:completion_enable_auto_paren = v:true
let g:completion_trigger_on_delete = v:true
let g:completion_auto_change_source = 1
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_chain_complete_list = {
	\ 'default': [
		\ {'complete_items': ['snippet', 'lsp', 'path']},
		\ {'mode': 'keyp'},
		\ {'mode': 'keyn'},
	\ ],
	\ 'lisp': [
		\ {'complete_items': ['snippet', 'vlime', 'path']},
		\ {'mode': 'keyp'},
		\ {'mode': 'keyn'},
	\ ],
	\ 'dap-repl': [
		\ {'mode': 'omni'},
		\ {'mode': 'keyp'},
		\ {'mode': 'keyn'},
	\ ],
\ }
