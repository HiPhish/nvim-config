local fn = vim.fn
local fun = require 'hiphish.util.functional'
local comp = require 'hiphish.statusline.components'
local util = require 'hiphish.statusline.util'

local M = {}

local sep = ' │ '

local function not_empty(s)
	return s ~= ''
end

local statusline = {
	-- Thunks to execute for side effects
	before = {
		util.hi_statusline_accent_mode,
	},
	ft = {
		[''] = {
			active = function()
				local result = {
					'%#StatusLineAccentMode# ',
					comp.mode(),
					' %#StatusLineAccent# ',
					comp.filename(),
					' %#StatusLine# ',
					comp.gps(),
					'%=',
					table.concat(fun.filter(not_empty, {
						vim.opt.fileformat:get(),
						vim.opt.fileencoding:get(),
						comp.diagnostics('StatusLine', sep)
					}), sep),
					' %#StatusLineAccent# ',
					comp.filetype(),
					comp.lsp_status(),
					' %#StatusLineAccentMode# %P %3l:%02c ',
				}
				return table.concat(fun.filter(function(txt) return txt ~= '' end, result))
			end,
			inactive = function()
				return ' %F %= %3p%% │ %3l:%02c'
			end,
		},
		dirvish = {
			active = function()
				return table.concat {
					'%#StatusLineAccentMode# Dirvish %#StatusLineAccent# ',
					fn.fnamemodify(fn.getcwd(), ':~'),
					fn.fnamemodify(fn.expand('%'), ':.'),
					' %#StatusLine# ',
					'%=%#StatusLineAccentMode# %2l:%c '
					}
			end,
			inactive = function()
				return table.concat {
					'%#StatusLineNC# ',
					fn.fnamemodify(fn.getcwd(), ':~'),
					fn.fnamemodify(fn.expand('%'), ':.'),
					'%=%P %l:%c'
					}
			end
		},
		man = {
			active = function()
				local fname = fn.fnamemodify(fn.expand('%'), ':t')
				local ftype = vim.bo.filetype
				return table.concat {
					'%#StatusLineAccentMode# ',
					fname,
					' %#StatusLine#%=',
					ftype,
					' %#StatusLineAccent# %P %#StatusLineAccentMode# %l:%c ',
				}
			end,
			inactive = function()
				local fname = fn.fnamemodify(fn.expand('%'), ':t')
				local ftype = vim.bo.filetype
				return table.concat{'%#StatusLineNC# ', fname, ' %=', ftype, ' │ %P │ %l:%c '}
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
	},
}

-- Returns the complete status line string for the current window
function M.get(type)
	local ft = vim.bo.filetype
	local spec = statusline.ft[ft] or statusline.ft[''] or {}
	local before = statusline.before or {}
	for _, hook in ipairs(before) do
		hook()
	end
	local result = spec[type] and spec[type]() or ''
	return result
end

return M
