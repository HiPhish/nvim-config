local success, neotest = pcall(require, 'neotest')
if not success then return end

neotest.setup {
	adapters = {
		require 'neotest-python' {
			dap = {justMyCode = false}
		}
	},
	icons = {
		skipped = '-',
	},
	summary = {
		expand_errors = true,
	},
	output = {
		open_on_run = true
	},
}

---[ NEOTEST COMMAND ]---------------------------------------------------------

-- Separator pattern for command arguments (whitespace preceeded by an even
-- number of backslashes)
local sep = '\\v[^\\\\](\\\\\\\\)*\\zs\\s+'

local subcommands = {
	run = function()
		neotest.run.run()
	end,
	stop = function(fargs)
		local config = {}
		if fargs[1] == 'debug' then
			config['strategy'] = 'dap'
		end
		neotest.run.stop(config)
	end,
	summary = function(fargs)
		local how = fargs[1] or 'toggle'
		if how == 'open' then
			neotest.summary.open()
		elseif how == 'close' then
			neotest.summary.close()
		elseif how == 'toggle' then
			neotest.summary.toggle()
		else
			error(string.format('Unknown Neotest command "open %s"', how))
		end
	end,
	output = function ()
		neotest.output.open {
		}
	end
}

local completions = {
	run = {debug = {}},
	summary = {open = {}, close = {}, toggle = {}},
	output = {},
	stop = {},
}

local function complete_cmd(arg_lead, cmd_line, _)
	local args = vim.list_slice(vim.fn.split(cmd_line, sep), 2)
	local current = completions
	-- Whether the current last argument has been completed
	local args_complete = vim.fn.match(cmd_line, sep .. '$') > 0

	for i, arg in ipairs(args) do
		if i >= #args and not args_complete then
			local temp = {}
			for k, _ in pairs(current) do
				if vim.startswith(k, arg_lead) then temp[k] = current[k] end
			end
			current = temp
			break
		end
		current = completions[arg]
		if not current then break end
	end

	return vim.tbl_keys(current or {})
end

local function neotest_cmd(args)
	local fargs = args.fargs
	local handler = subcommands[fargs[1]]
	if handler then
		handler(vim.list_slice(fargs, 2))
	else
		error(string.format('Neotest: no handler for \'%s\'', fargs[1]))
	end
end

vim.api.nvim_create_user_command('Neotest', neotest_cmd, {nargs='*', complete=complete_cmd})
