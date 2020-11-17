--- Various predefined tests for the language server
local M = {}


-- [ HELPERS ] ----------------------------------------------------------------
local function filereadable(fname)
	return vim.fn.filereadable(fname) ~= 0
end


--- Test which will always pass
function M.always()
	return true
end

--- There is a local primary LSP settings file.
function M.has_local_settings_file()
	return filereadable('lua-lsp.json')
end

--- There is a local secondary LSP settings file.
function M.has_local_extra_file()
	return filereadable('lua-lsp-extra.json')
end

--- The current directory is the Neovim config directory.
function M.is_nvim_conf_dir()
	return vim.fn.getcwd() == vim.fn.stdpath('config')
end

--- There exists a `.rockspec` file.
function M.has_rockspec()
	local specs = vim.fn.glob('*.rockspec', true, true)
	for _, spec in ipairs(specs) do
		if filereadable(spec) then return true end
	end
	return false
end


-------------------------------------------------------------------------------
return M
