local fn = vim.fn

local function get_bufname(i)
	local buflist = fn.tabpagebuflist(i)
	local winnr = fn.tabpagewinnr(i)
	local bufname = fn.bufname(buflist[winnr])
	if bufname == '' then
		bufname = '[No Name]'
	end

	return fn.fnamemodify(bufname, ':t')
end

local function make_tab_entries(entries, active)
	local result = ''

	for i, entry in ipairs(entries) do
		local bufname = get_bufname(i)
		local hl = i == active and 'TabLineSel' or 'TabLine'
		local sep = i ~= active and i ~= active-1 and i ~= #entries
			and '│'
			or ' '

		local render = string.format('%%#%s# %%%dT%d %s %%T%s', hl, i, i, bufname, sep)
		result = result .. render
	end

	return result
end


return function()
	local result = make_tab_entries(fn.range(fn.tabpagenr('$')), fn.tabpagenr())

	result = result .. '%#TabLineFill#%=%#TabLine# %{strftime("%H:%M")} │ %{strftime("%Y-%m-%d %a")} '
	return result
end
