--- This file contains all the configuration for the built-in LSP client


--- [ OVERRIDE CLIENT FUNCTIONS ] ---------------------------------------------
-- Here I override the functions of the LSP client to my liking. An override
-- should preferably still call the original function for better
-- maintainability.


-- Inject a maximum width into the window options.
do
	local old_stylize_markdown = vim.lsp.util.stylize_markdown
	vim.lsp.util.stylize_markdown = function (bufnr, cotents, opts)
		-- opts.max_width = opts.max_width or 90
		return old_stylize_markdown(bufnr, cotents, opts)
	end
end

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
	vim.lsp.handlers.hover, {
		-- max_width = 80,
	}
)

-- Displays nicely presented startup progress messages
do
	local success, fidget = pcall(require, 'fidget')
	if success then
		fidget.setup {
			progress = {
				display = {
					-- progress_icon = {'dots_pulse'},
					progress_icon = {
						pattern = {' ', ' ', ' '},
					},
				}
			},
			notification = {
				window = {
					winblend = 30,
					border = 'rounded',
				},
			},
		}
	end
end

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(_args)
		-- Remap keys
		local opts = {noremap = true, silent = true, buffer = 0}
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
	end
})
