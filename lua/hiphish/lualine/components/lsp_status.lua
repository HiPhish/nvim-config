return function()
	local clients = vim.lsp.buf_get_clients()

	for _, client in pairs(clients) do
		if not vim.lsp.client_is_stopped(client.id) then
			return '•'
		end
	end
	local result = '×'
	return result
end
