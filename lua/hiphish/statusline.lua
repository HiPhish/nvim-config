local fn = vim.fn
local fun = require 'hiphish.util.functional'
local comp = require 'hiphish.statusline.components'
local util = require 'hiphish.statusline.util'

local M = {}

local sep = ' │ '

local statusline = {
	-- Thunks to execute for side effects
	before = {
		util.hi_statusline_accent_mode,
	},
	ft = {
		[''] = {
			active = function()
				local diag = comp.diagnostics('StatusLine', sep)
				local result = {
					'%#StatusLineAccentMode# ',
					comp.mode(),
					' %#StatusLineAccent# ',
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
					-- file progress
					' %#StatusLineAccentMode# %P %3l:%02c ',  -- line info
				}
				return table.concat(fun.filter(function(txt) return txt ~= '' end, result))
			end,
			inactive = function()
				return ' %F %= %3p%% │ %3l:%02c'
			end,
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
					'%#StatusLineAccentMode# Dirvish %#StatusLineAccent# ',
					fn.fnamemodify(fn.getcwd(), ':~'),
					' %#StatusLine# ',
					fn.fnamemodify(fn.expand('%'), ':.'),
					'%=%#StatusLineAccentMode# %2l:%c '
					}
			end,
			inactive = function()
				return table.concat {
					'%#StatusLineAccent# Dirvish %#StatusLineNC# ',
					fn.fnamemodify(fn.expand('%'), ':.'),
					'%=%P %l:%c'
					}
			end
		},
		man = {
			active = function()
				return table.concat {
					string.format('%%#StatusLineAccentMode# %s %%#StatusLine#%%=', fn.fnamemodify(fn.expand('%'), ':t')),
					vim.bo.filetype,
					' %#StatusLineAccent# %P %#StatusLineAccentMode# %l:%c ',
				}
			end,
			inactive = function()
				return ''
			end
		}
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
