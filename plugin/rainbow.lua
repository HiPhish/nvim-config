local api = vim.api

---@type rainbow_delimiters.config
vim.g.rainbow_delimiters = {
	strategy = {
		commonlisp = 'rainbow-delimiters.strategy.local',
		xml = function(bufnr)
			-- Disable for large files
			if api.nvim_buf_line_count(bufnr) > 10000 then
				return
			end
			return 'rainbow-delimiters.strategy.global'
		end,
	},
	query = {
		query = function (bufnr)
            local is_nofile = vim.bo[bufnr].buftype == 'nofile'
            return is_nofile and 'rainbow-blocks' or 'rainbow-delimiters'
		end
	},
}
