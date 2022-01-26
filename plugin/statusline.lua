-- https://nuxshed.github.io/blog/custom-nvim-statusline.html#org5854583
vim.api.nvim_exec([[
	augroup StatusLine
	au!
	au WinEnter,BufEnter * setlocal statusline=%{%luaeval('require(\"hiphish.statusline\").get(\"active\")')%}
	au WinLeave,BufLeave * setlocal statusline=%{%luaeval('require(\"hiphish.statusline\").get(\"inactive\")')%}
	augroup END
]], false)

---------------------------------------------------------------------------------
-- local fn = vim.fn
-- local filename = require 'hiphish.lualine.components.filename'
-- local gps = require 'hiphish.lualine.components.gps'

-- local function width_criterion(width)
-- 	return function()
-- 		return fn.winwidth(0) >= width
-- 	end
-- end

-- local function negate(f)
-- 	return function()
-- 		return not f()
-- 	end
-- end


-- require'lualine'.setup {
-- 	options = {
-- 		theme = 'solarized',
-- 	},
-- 	sections = {
-- 		lualine_a = {'mode'},
-- 		lualine_b = {filename},
-- 		lualine_c = {
-- 			gps,
-- 		},
-- 		lualine_x = {
-- 			{
-- 				'fileformat',
-- 				icons_enabled = false,
-- 				condition = width_criterion(100),
-- 			}, {
-- 				'encoding',
-- 				condition = width_criterion(100),
-- 			}, {
-- 				'diagnostics',
-- 				sections = {'error'},
-- 				sources = {'nvim_diagnostic'},
-- 				symbols = {error = 'E: ', warn = 'W: ', info = 'I: '},
-- 			}, {
-- 				'diagnostics',
-- 				sections = {'warn'},
-- 				sources = {'nvim_diagnostic'},
-- 				symbols = {error = 'E: ', warn = 'W: ', info = 'I: '},
-- 			}, {
-- 				'filetype',
-- 				condition = width_criterion(60),
-- 			}, {
-- 				require 'hiphish.lualine.components.lsp_status',
-- 				cond = function()
-- 					return #vim.lsp.buf_get_clients() > 0
-- 				end
-- 			},
-- 		},
-- 		lualine_y = {
-- 			{
-- 				'progress',
-- 				condition = width_criterion(60),
-- 			}, {
-- 				'filetype',  -- Move file type one section to the right in narrow windows
-- 				condition = negate(width_criterion(60))
-- 			},
-- 		},
-- 		lualine_z = {'location'},
-- 	},
-- 	inactive_sections = {
-- 		lualine_a = {},
-- 		lualine_b = {},
-- 		lualine_c = {filename},
-- 	},
-- 	extensions = {
-- 		'fzf',
-- 		'nerdtree',
-- 		'quickfix',
-- 		'fugitive',
-- 		require 'hiphish.lualine.extensions.dirvish',
-- 		require 'hiphish.lualine.extensions.man',
-- 	}
-- }
