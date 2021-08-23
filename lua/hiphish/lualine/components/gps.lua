local success, gps = pcall(require, 'nvim-gps')

if not success then
	return {}
end

return {
	gps.get_location,
	condition = gps.is_available,
}
