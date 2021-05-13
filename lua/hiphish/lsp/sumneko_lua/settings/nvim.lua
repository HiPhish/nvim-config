-- See https://gist.github.com/folke/fe5d28423ea5380929c3f7ce674c41d8

local library = {}
for _, p in ipairs(vim.split(vim.o['runtimepath'], ',')) do
	if vim.fn.isdirectory(p .. '/lua') ~= 0 then
		library[p] = true
	end
end

local M = {
	Lua = {
		runtime = {
			version = jit and 'LuaJIT' or _VERSION,
			path = {
				'lua/?.lua',
				'lua/?/init.lua',
			},
		},

		diagnostics = {
			globals = {
				'vim',
			},
		},

		workspace = {
			library = library
		},
	}
}

if jit then
	local globals = M.Lua.diagnostics.globals
	globals[#globals + 1] = 'jit'
end

return M
