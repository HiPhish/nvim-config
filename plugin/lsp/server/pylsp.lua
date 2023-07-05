local nvim_lsp = require'lspconfig'
local defaults = require 'hiphish.lsp.defaults'

local plugins = {
	-- If this plugin does not work try running MyPy from the
	-- command line first
	pylsp_mypy = {
		enabled = true,
		live_mode = true,
	},
	rope_autoimport = {
		enabled = false,
	}
}

if vim.fn.executable('ruff') then
	plugins.ruff = {
		enabled = true,
		extendSelect = {'I'}
	}
end

if vim.fn.DetectPythonFormatters then
	-- dummy-call the function first; it returns nil on first call. This is a
	-- bug in Neovim
	vim.fn.DetectPythonFormatters()
	local available_formatters = vim.fn.DetectPythonFormatters()
	for _, name in ipairs(available_formatters) do
		if name == 'black' then
			plugins['python-lsp-black'] = {
			}
		end
	end
	if available_formatters['black'] then
		-- plugins['python-lsp-black'] = {
		plugins['black'] = {
			enabled = false
		}
	end
end

nvim_lsp.pylsp.setup {
	cmd = {
		vim.fn.executable('pylsp') ~= 0
			and 'pylsp'
			or vim.env.HOME .. '/.local/bin/pylsp'
	},
	capabilities = defaults.capabilities,
	settings = {
		pylsp = {
			plugins = plugins
		}
	},
}
