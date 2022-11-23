local M = {}

local fn = vim.fn
local api = vim.api
local has_gps, gps = pcall(require, 'nvim-gps')
local severity = vim.diagnostic.severity
local fun = require 'hiphish.util.functional'
local util = require 'hiphish.statusline.util'

local function lsp_indicator(buf)
	local clients = vim.lsp.get_active_clients {bufnr = buf}

	for _, client in pairs(clients) do
		if not vim.lsp.client_is_stopped(client.id) then
			return '•'
		end
	end
	return ''
end

function M.filename()
	local winid = vim.g.statusline_winid
	local bufnr = vim.fn.winbufnr(winid)
	local n = fn.substitute(fn.bufname(bufnr), '\\v\\%', '%%', 'g')
	local info = fn.getbufinfo(bufnr)[1]

	local result = fn.fnamemodify(n, ':t')

	if result == '' then
		result = '[No Name]'
	end
	if info.changed ~= 0 then
		result = result .. ' +'
	end
	if fn.getbufvar(bufnr, '&readonly') ~= 0 then
		result = ' ' .. result
	end

	return result
end

function M.filetype(buf)
	local ft = vim.bo[buf or 0].filetype or ''
	local marker = lsp_indicator(buf)
	return string.format('%s%s', ft, marker)
end

function M.mode()
	local current_mode = api.nvim_get_mode().mode
	local spec = util.modes[current_mode] or {}
	return spec.label or ''
end


function M.diagnostics(hl_base, sep)
	local specs = {
		[severity.ERROR] = {name = 'Error', label = 'E', hi = 'Error', message = nil},
		[severity.WARN ] = {name = 'Warn' , label = 'W', hi = 'Warn' , message = nil},
		[severity.INFO ] = {name = 'Info' , label = 'I', hi = 'Info' , message = nil},
		[severity.HINT ] = {name = 'Hint' , label = 'H', hi = 'Hint' , message = nil},
	}

	local bg = fn.synIDattr(fn.synIDtrans(fn.hlID(hl_base)), 'bg')

	for level, spec in pairs(specs) do
		local count = vim.tbl_count(vim.diagnostic.get(0, {severity = level}))
		if count ~= 0 then
			local name = spec.name
			local sign = fn.sign_getdefined(string.format('DiagnosticSign%s', name))[1] or {}
			local hi = spec.hi
			local label = sign.text or spec.label
			local fg = fn.synIDattr(fn.synIDtrans(fn.hlID(string.format('Diagnostic%s', name))), 'fg')
			-- Create new highlight group
			vim.cmd(string.format('hi StatusLineDiagnostic%s guifg=%s guibg=%s', hi, fg, bg))
			spec.message = string.format('%%#StatusLineDiagnostic%s#%s%d%%#%s#', hi, label, count, hl_base)
		end
	end

	local derp = fun.imap(
		function(spec) return spec.message end,
		fun.filter(function(spec) return spec.message end, specs))

	return table.concat(derp, sep)
end

if has_gps then
	gps.setup {
		icons = {
			['class-name'] = '',
			['function-name'] = '',
			['method-name'] = '',
			['container-name'] = '',
			['tag-name'] = '',
		},
		languages = {
			vim = false,
		},
		separator = ' ╱ ',
		depth_limit_indicator = '…'
}
end

function M.gps()
	return has_gps and gps.is_available() and gps.get_location() or ''
end

-- Title of a REPL instance (from repl.nvim plugin)
function M.repl_title()
	local type = vim.b.repl['-'].type
	local repl
	for _, scope in ipairs({'b', 'w', 't', 'g'}) do
		repl = (vim[scope].repl or {})[type]
		if repl then break end
	end
	if not repl then return end
	return repl.title or string.format('REPL (%s), type')
end

return M
