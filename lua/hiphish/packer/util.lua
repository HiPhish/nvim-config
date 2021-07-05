--- Various helpers for defining packages
local M = {}


--- Specify a local path with a fallback specification if the path does not
--- exist.
function M.either(path, fallback)
	if vim.fn.isdirectory(vim.fn.expand(path)) ~= 0 then
		return path
	end
	return fallback
end


return M
