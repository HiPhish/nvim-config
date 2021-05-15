local fn = vim.fn

local function dirvish()
	return 'Dirvish'
end

local function filename()
	return fn.fnamemodify(fn.expand('%'), ':.')
end

return {
	sections = {
		lualine_a = {dirvish},
		lualine_b = {filename},
		lualine_z = {'location'}
	},
	filetypes = {'dirvish'}
}
