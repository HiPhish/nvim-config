-- Settings for the Vlime plugin: https://github.com/vlime/vlime


-- My quicklisp is installed to a non-standard location
vim.g.lisp_host_quicklisp_setup = '~/.local/share/quicklisp/setup.lisp'

-- I don't know why I would not want this enabled
vim.g.vlime_cl_use_terminal = true

vim.g.vlime_window_settings = {
	repl = {size = 10}
}

vim.g.vlime_indent_keywords = {
	['if'] = 1
}


-- Settings for Vlime buffers
vim.api.nvim_create_augroup('vlime', {})
vim.api.nvim_create_autocmd({'BufReadPost', 'BufNewFile', 'BufEnter', 'WinNew'}, {
	group = 'vlime',
	pattern = 'vlime*',
	desc = 'Override file settings for Vime UI buffers',
	command = 'setlocal nonumber nospell'
})

vim.api.nvim_create_autocmd({'BufReadPost', 'BufNewFile', 'BufEnter', 'WinNew'}, {
	group = 'vlime',
	pattern = {'vlime_sldb', 'vlime_threads'},
	desc = 'Highlight cursor line for certain Vlime buffers',
	command = 'setlocal cursorline'
})

vim.api.nvim_create_autocmd({'BufReadPost', 'BufNewFile', 'BufEnter', 'WinNew'}, {
	group = 'vlime',
	pattern = {'vlime_repl'},
	desc = 'Fix the window height for certain Vlime buffers',
	command = 'setlocal winfixheight'
})
