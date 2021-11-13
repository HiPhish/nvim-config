local success, gps = pcall(require, 'nvim-gps')

if not success then
	return {}
end

gps.setup {
	icons = {
		['class-name'] = '',
		['function-name'] = '',
		['method-name'] = '',
		['container-name'] = '',
		['tag-name'] = '',
	},
	languages = {
		vim = false,
	},
	separator = ' ╱ ',
	depth_limit_indicator = '…'
}

return {
	gps.get_location,
	cond = gps.is_available,
}
