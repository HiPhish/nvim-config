-- SPDX-FileCopyrightText: © 2021 HiPhish
-- SPDX-License-Identifier: Unlicense

-- Auto-start Tree-sitter highlighting
vim.api.nvim_create_autocmd('BufWinEnter', {
	pattern = '*',
	callback = function(_args)
		if vim.bo.filetype ~= '' then
			-- Silently ignore failures
			pcall(vim.treesitter.start)
		end
	end
})
