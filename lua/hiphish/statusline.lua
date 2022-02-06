local fn = vim.fn
local fun = require 'hiphish.util.functional'
local comp = require 'hiphish.statusline.components'
local util = require 'hiphish.statusline.util'

local M = {}

local sep = ' │ '

local function not_empty(s)
	return s ~= ''
end

local function is_loclist()
  return vim.fn.getloclist(0, { filewinid = 1 }).filewinid ~= 0
end

local statusline = {
	-- Thunks to execute for side effects
	before = {
		util.hi_statusline_accent_mode,
	},
	terminal = {
		-- Return nil to use the default file type status line
		active = function()
			if (vim.b.repl or {})['-'] then
				local items = {
					'%#StatusLineAccentMode# ',
					comp.mode(),
					' %#StatusLineAccent# ',
					comp.repl_title(),
					' %#StatusLine#'}
				return table.concat(items)
			end
		end,
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
			inactive = ' %F %= %3p%% │ %3l:%02c'
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
		fugitive = {
			active = function()
				return table.concat {
					'%#StatusLineAccentMode# ',
					string.format(' %s', vim.fn.FugitiveHead()),
					' %#StatusLine#%=%#StatusLineAccentMode# %2l:%2c'
				}
			end,
			inactive = function()
				return table.concat {
					'%#StatusLineNC# ',
					string.format(' %s', vim.fn.FugitiveHead()),
					'%=%2l:%2c'
				}
			end
		},
		man = {
			active = function()
				local ftype = vim.bo.filetype
				return table.concat {
					'%#StatusLineAccentMode# %t %#StatusLine#%=',
					ftype,
					' %#StatusLineAccent# %P %#StatusLineAccentMode# %l:%c ',
				}
			end,
			inactive = function()
				local ftype = vim.bo.filetype
				return table.concat{'%#StatusLineNC# %t%=', ftype, ' │ %P │ %l:%c '}
			end
		},
		nerdtree = {
			active = '%#StatusLineAccentMode# NERDTree %#StatusLine#',
			inactive = '%#StatusLineNC# NERDTree'
		},
		qf = {
			active = function()
				local label = is_loclist() and 'Location' or 'Quickfix'
				local title
				if is_loclist() then
					title = vim.fn.getloclist(0, { title = 0 }).title
				else
					title = vim.fn.getqflist({ title = 0 }).title
				end
				return table.concat {
					'%#StatusLineAccentMode#',
					label,
					' %#StatusLineAccent# ',
					title,
					' %#StatusLine#%=%#StatusLineAccentMode# %P %l:%c'
				}
			end,
			inactive = function()
				local label = is_loclist() and 'Location' or 'Quickfix'
				local title
				if is_loclist() then
					title = vim.fn.getloclist(0, { title = 0 }).title
				else
					title = vim.fn.getqflist({ title = 0 }).title
				end
				return table.concat {
					'%#StatusLineNC#',
					label,
					sep,
					title,
					'%=%P %l:%c'
				}
			end
		},
	},
}

-- Returns the complete status line string for the current window
function M.get(mode)
	local result

	local before = statusline.before or {}
	for _, hook in ipairs(before) do
		hook()
	end

	-- Terminal buffers are a special case
	if vim.bo.buftype == 'terminal' then
		local spec = statusline.terminal or {}
		local thunk = spec[mode]
		result = type(thunk) ~= 'function' and thunk or (thunk and thunk())
	end

	if not result then
		local ft = vim.bo.filetype
		local spec = statusline.ft[ft] or statusline.ft[''] or {}
		result = spec[mode]
	end

	return type(result) ~= 'function' and result or result()
end

return M
