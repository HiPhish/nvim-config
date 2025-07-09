-- https://github.com/Prince781/vala-language-server


local function meson_matcher(path)
	local meson = vim.fn.glob(vim.fs.joinpath(path, 'meson.build'))
	if meson == '' then
		return nil
	end
	for line in io.lines(meson) do
		-- Skip meson comments
		if not line:match '^%s*#' then
			local str = line:gsub('%s+', '')
			if str ~= '' then
				if str:match '^project%s*%(' then
					return path
				else
					break
				end
			end
		end
	end
end


local function root_dir(bufnr, cb)
	local util = require 'lspconfig.util'

	local fname = vim.api.nvim_buf_get_name(bufnr)
	if fname == '' then cb(vim.fn.getcwd()) end

	local root = util.search_ancestors(fname, meson_matcher)
	if root then
		cb(root)
	else
		cb(vim.fn.getcwd())
	end
end


return {
	cmd = {'vala-language-server'},
	filetypes = {'vala', 'genie'},
	root_dir = root_dir,
}
