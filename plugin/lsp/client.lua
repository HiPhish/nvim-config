-- This file contains all the configuration for the built-in LSP client


local api = vim.api
local util = require'vim.lsp.util'
local local_util = require 'hiphish.lsp.util'

--- [ OVERRIDE CLIENT FUNCTIONS ] ---------------------------------------------
-- Here I override the functions of the LSP client to my liking. An override
-- should preferably still call the original function for better
-- maintainability.


-- Store original functions here for back reference. First declare the
-- function, then assign it wrapped inside a check. The purpose of this
-- roundabout way is to make sure we do not overwrite the first saved function
-- if this script gets sourced a second time.
local fancy_floating_markdown
if not fancy_floating_markdown then
	fancy_floating_markdown = util['fancy_floating_markdown']
end

-- Inject a maximum width into the window options.
util['fancy_floating_markdown'] = function (contents, opts)
	if opts['max_width'] then goto call end
	opts['max_width'] = 100  -- I could use a fancy computed value instead

	::call::
	return fancy_floating_markdown(contents, opts)
end

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
	vim.lsp.handlers.hover, {
		border = 'rounded',  -- See `:h nvim_open_win()`
		max_width = 80,
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

api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
        local bufnr = args.buf

		-- Use LSP as default formatter
		vim.bo[bufnr].formatexpr =  'v:lua.vim.lsp.formatexpr()'

		-- Remap keys
		local opts = {noremap = true, silent = true}
		for mode, mappings in pairs(local_util.mappings) do
			for lhs, rhs in pairs(mappings) do
				api.nvim_buf_set_keymap(0, mode, lhs, rhs, opts)
			end
		end
	end
})
