local fn = vim.fn

local filename = require 'hiphish.lualine.components.filename'

local function width_criterion(width)
	return function()
		return fn.winwidth(0) >= width
	end
end

local function negate(f)
	return function()
		return not f()
	end
end

require'lualine'.setup {
	options = {
		theme = 'solarized',
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {filename},
		lualine_c = {
			{
				require 'hiphish.lualine.components.lsp_status',
				condition = function()
					return #vim.lsp.buf_get_clients() > 0
				end
			}, {
				'diagnostics',
				sections = {'warn'},
				sources = {'nvim_lsp'},
				symbols = {error = 'E: ', warn = 'W: ', info = 'I: '},
			}, {
				'diagnostics',
				sections = {'error'},
				sources = {'nvim_lsp'},
				symbols = {error = 'E: ', warn = 'W: ', info = 'I: '},
			}
		},
		lualine_x = {
			{
				'fileformat',
				icons_enabled = false,
				condition = width_criterion(100),
			}, {
				'encoding',
				condition = width_criterion(100),
			}, {
				'filetype',
				condition = width_criterion(60),
			},
		},
		lualine_y = {
			{
				'progress',
				condition = width_criterion(60),
			}, {
				'filetype',  -- Move file type one section to the right in narrow windows
				condition = negate(width_criterion(60))
			},
		},
		lualine_z = {'location'},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {filename},
	},
	extensions = {
		'fzf',
		'nerdtree',
		'quickfix',
		'fugitive',
		require 'hiphish.lualine.extensions.dirvish',
	}
}
