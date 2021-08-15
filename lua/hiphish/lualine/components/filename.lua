local fn = vim.fn

return function()
	local winid = vim.g.statusline_winid
	local bufnr = vim.fn.winbufnr(winid)
	local n = fn.substitute(fn.bufname(bufnr), '\\v\\%', '%%', 'g')
	local info = fn.getbufinfo(bufnr)[1]

	local result = fn.fnamemodify(n, ':t')

	if result == '' then
		result = '[No Name]'
	end
	if info.changed ~= 0 then
		result = result .. ' +'
	end
	if fn.getbufvar(bufnr, '&readonly') ~= 0 then
		result = ' ' .. result
	end

	return result
end

