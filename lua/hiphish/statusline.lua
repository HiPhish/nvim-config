-- SPDX-FileCopyrightText: © 2022 HiPhish
-- SPDX-License-Identifier: 0BSD

local fn = vim.fn
local api = vim.api
local comp = require 'hiphish.statusline.components'
local util = require 'hiphish.statusline.util'

local M = {}

---The default item separator.
local sep = '╱'
-- local sep = ' │ '

---Returns the buffer object in the context of the current status line
local function get_current_buf()
	return api.nvim_win_get_buf(vim.g.statusline_winid)
end

---True if the string argument is not empty
local function not_empty(_, s)
	return s ~= ''
end

---Whether the current window is a location list window
local function is_loclist()
	return fn.getloclist(vim.g.statusline_winid, {filewinid = 1}).filewinid ~= 0
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
					' %* ',
					comp.navic(),
					'%=',
					table.concat(fn.filter({
						comp.diagnostics('StatusLine', sep)
					}, not_empty), sep),
				}
				return table.concat(fn.filter(result, not_empty))
			end,
			inactive = function()
				local result = {
					comp.filename(),
					'%= %3p%%', sep, '%3l:%02c'
				}
				return table.concat(fn.filter(result, not_empty))
			end
		},
	},
}

local winbar = {
	before = {
		util.hi_statusline_accent_mode,
	},
	terminal = {
		-- Return nil to use the default file type status line
		active = function()
			if (vim.b.repl or {})['-'] then
				local template = '%%#StatusLineAccentMode#%s %%#StatusLine#%%=%%P | %%3l:%%02c'
				return string.format(template, comp.repl_title())
			end
			return '%#StatusLineAccentMode#%t %#StatusLine#%=%P | %3l:%02c'
		end,
	},
	ft = {
		[''] = {
			active = function()
				local buf = get_current_buf()
				local result = {
					'%#StatusLineAccentMode# ',
					comp.filename(),
					' %#StatusLine#%=',
					table.concat(fn.filter({
						vim.bo[buf].fileformat or '',
						vim.bo[buf].fileencoding or '',
						comp.filetype(buf),
						'%P',
						'%3l:%02c ',
					}, not_empty), sep),
				}
				return table.concat(fn.filter(result, not_empty))
			end,
			inactive = function()
				local result = {
					'%#StatusLineNC#',
					comp.filename(),
					'%= %3p%%', sep, '%3l:%02c'
				}
				return table.concat(fn.filter(result, not_empty))
			end
		},
		nerdtree = {
			active = '%#StatusLineAccentMode#NERDTree %#StatusLine#',
			inactive = '%#StatusLineNC#NERDTree',
		},
		dirvish = {
			active = function()
				return table.concat {
					'%#StatusLineAccentMode#',
					fn.fnamemodify(fn.expand('%'), ':.'),
					'%#StatusLine# ',
					'%=%#StatusLineAccentMode# %2l:%c '
					}
			end,
			inactive = function()
				local fname = api.nvim_buf_get_name(get_current_buf())
				return string.format('%%#StatusLineNC#%s', fn.fnamemodify(fname, ':~'))
			end
		},
		fugitive = {
			active = function()
				return table.concat {
					'%#StatusLineAccentMode# ',
					string.format(' %s', vim.fn.FugitiveHead()),
					' %#StatusLine#%=%#StatusLineAccentMode# %2l:%2c',
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
				return table.concat{'%#StatusLineNC# %t%=', ftype, sep, '%P', sep, '%l:%c '}
			end
		},
		qf = {
			active = function()
				local label = is_loclist() and 'Location' or 'Quickfix'
				local title
				if is_loclist() then
					title = vim.fn.getloclist(vim.g.statusline_winid, {title = 0}).title
				else
					title = vim.fn.getqflist({title = 0}).title
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
					title = vim.fn.getloclist(vim.g.statusline_winid, {title = 0}).title
				else
					title = vim.fn.getqflist({title = 0}).title
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
local function get(bar, mode)
	local result

	local before = bar.before or {}
	for _, hook in ipairs(before) do
		hook()
	end

	-- Terminal buffers are a special case
	if vim.bo.buftype == 'terminal' then
		local spec = bar.terminal or {}
		result = spec[mode]
	end

	if not result then
		local ft = vim.bo[get_current_buf()].filetype
		local spec = bar.ft[ft] or bar.ft[''] or {}
		result = spec[mode]
	end

	if result then
		return type(result) ~= 'function' and result or result()
	end
	return ''
end

function M.statusline(mode)
	return get(statusline, mode)
end

function M.winbar(mode)
	return get(winbar, mode)
end

return M
