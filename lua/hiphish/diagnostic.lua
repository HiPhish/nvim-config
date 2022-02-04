-- Personal diagnostic settings and functions
local M = {}
local diagnostic = vim.diagnostic

-- Settings for floating windows
local win_opts = {
	border = 'rounded'
}

-- Open the floating diagnostic window
function M.open_float()
	diagnostic.open_float(win_opts)
end

return M
