---@type rainbow_delimiters.config
vim.g.rainbow_delimiters = {
	strategy = {
		commonlisp = 'rainbow-delimiters.strategy.local',
	},
	query = {
		query = function (bufnr)
            local is_nofile = vim.bo[bufnr].buftype == 'nofile'
            return is_nofile and 'rainbow-blocks' or 'rainbow-delimiters'
		end
	},
}
