local fn = vim.fn

local function filename()
	return fn.fnamemodify(fn.expand('%'), ':t')
end

return {
	sections = {
		lualine_a = {filename},
		lualine_x = {'filetype'},
		lualine_y = {'progress'},
		lualine_z = {'location'},
	},
	filetypes = {'man'}
}
