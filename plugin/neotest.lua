local success, neotest = pcall(require, 'neotest')
if not success then return end

local adapters = {
	require 'neotest-python' {
		runner = 'pytest',
		dap = {
			justMyCode = false
		},
	},
}

pcall(function()
	adapters[#adapters + 1] = require 'neotest-elixir' {
	}
end)

neotest.setup {
	adapters = adapters,
	consumers = {},
	diagnostic = {
		enabled = true,
		severity = 1
	},
	floating = {
		border = "rounded",
		max_height = 0.6,
		max_width = 0.6,
		options = {}
	},
	highlights = {
		adapter_name = 'NeotestAdapterName',
		border = 'NeotestBorder',
		dir = 'NeotestDir',
		expand_marker = 'NeotestExpandMarker',
		failed = 'NeotestFailed',
		file = 'NeotestFile',
		focused = "NeotestFocused",
		indent = 'NeotestIndent',
		marked = 'NeotestMarked',
		namespace = 'NeotestNamespace',
		passed = 'NeotestPassed',
		running = 'NeotestRunning',
		select_win = 'NeotestWinSelect',
		skipped = 'NeotestSkipped',
		target = 'NeotestTarget',
		test = 'NeotestTest',
		unknown = 'NeotestUnknown',
		watching = 'NeotestWatching',
	},
	icons = {
		skipped = '-',
	},
	log_level = 3,
	projects = {},
	state = {
		enabled = true
	},
	status = {
		enabled = true,
		signs = true,
		virtual_text = false
	},
	strategies = {
		integrated = {
			height = 40,
			width = 120,
		},
	},
	summary = {
		animated = true,
		enabled = true,
		expand_errors = true,
		follow = true,
		mappings = {
			attach = "a",
			clear_marked = "M",
			clear_target = "T",
			debug = "d",
			debug_marked = "D",
			expand = { "<CR>", "<2-LeftMouse>" },
			expand_all = "e",
			jumpto = "i",
			mark = "m",
			next_failed = "J",
			output = "o",
			prev_failed = "K",
			run = "r",
			run_marked = "R",
			short = "O",
			stop = "u",
			target = "t",
			watch = "w"
		},
		open = "botright vsplit | vertical resize 50"
	},
	output = {
		enabled = true,
		open_on_run = true
	},
	output_panel = {
		enabled = true,
		open = "botright split | resize 15"
	},
	quickfix = {
		enabled = true,
		open = false
	},
	watch = {
		enabled = true,
		symbol_queries = {
		-- elixir = <function 1>,
		-- lua = '		;query\n		;Captures module names in require calls\n		(function_call\n		  name: ((identifier) @function (#eq? @function "require"))\n		  arguments: (arguments (string) @symbol))\n	  ',
		-- python = "		;query\n		;Captures imports and modules they're imported from\n		(import_from_statement (_ (identifier) @symbol))\n		(import_statement (_ (identifier) @symbol))\n	  "
	  }
	}
}

---[ NEOTEST COMMAND ]---------------------------------------------------------

-- Separator pattern for command arguments (whitespace preceeded by an even
-- number of backslashes)
local sep = '\\v[^\\\\](\\\\\\\\)*\\zs\\s+'

local subcommands = {
	run = function()
		neotest.run.run {suite = false}
	end,
	stop = function()
		local config = {}
		neotest.run.stop(config)
	end,
	debug = function()
		neotest.run.run {suite = false, strategy = 'dap'}
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
			short = true,
			enter = false,
			quite = false,
			last_run = true,
			auto_close = true,
		}
	end
}

local completions = {
	run = {},
	debug = {},
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

vim.api.nvim_create_user_command('Ntest', neotest_cmd, {nargs='*', complete=complete_cmd})
