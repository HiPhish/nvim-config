local fn = vim.fn
local fun = require 'hiphish.util.functional'
local comp = require 'hiphish.statusline.components'
local util = require 'hiphish.statusline.util'

local M = {}

local sep = ' │ '

local statusline = {
	[''] = {
		active = function()
			local diag = comp.diagnostics('StatusLine', sep)
			local result = {
				'%#StatusLine#',
				comp.mode_indicator(),
				'%#StatusLineAccent# ',
				comp.filename(),
				' %#StatusLine# ',
				comp.gps(),
				'%=',
				vim.opt.fileformat:get(),
				diag ~= '' and sep or '',
				diag,
				' %#StatusLineAccent# ',
				comp.filetype(),
				comp.lsp_status(),
				sep,
				'%p%%',
				sep,
				-- file progress
				'%P %l:%c',  -- line info
			}
			return table.concat(fun.filter(function(txt) return txt ~= '' end, result))
		end,
		inactive = function()
			return ' %F '
		end,
		short = function()
			return '%#StatusLineNC#'
		end
	},
	nerdtree = {
		active = function()
			return 'NERDTree'
		end,
		inactive = function()
			return 'NERDTree'
		end
	},
	dirvish = {
		active = function()
			return table.concat {
				util.hl_mode(' Dirvish '),
				'%#StatusLineAccent# ',
				fn.fnamemodify(fn.getcwd(), ':~'),
				' %#StatusLine# ',
				fn.fnamemodify(fn.expand('%'), ':.'),
				'%=',
				util.hl_mode(' %2l:%c ')
				}
		end,
		inactive = function()
			return table.concat {
				'%#StatusLineAccent# Dirvish %#StatusLineNC# ',
				fn.fnamemodify(fn.expand('%'), ':.'),
				'%=',
				'%P %l:%c'
				}
		end
	},
	man = {
		active = function()
			return table.concat {
				util.hl_mode(string.format(' %s ', fn.fnamemodify(fn.expand('%'), ':t'))),
				'%#StatusLine#%=',
				vim.bo.filetype,
				' %#StatusLineAccent# %P ',
				util.hl_mode(' %l:%c '),
			}
		end,
		inactive = function()
			return ''
		end
	}
}

-- Returns the complete status line string for the current window
function M.get(type)
	local ft = vim.bo.filetype
	local spec = statusline[ft] or statusline[''] or {}
	local result = spec[type] and spec[type]() or ''
	return result
end

return M
