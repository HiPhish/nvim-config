local dap = require 'dap'
local ui = require 'dapui'

dap.listeners.after['event_initialized']['dapui_config'] = function()
	ui.open()
end

dap.listeners.before['event_terminated']['dapui_config'] = function()
	ui.close()
end

dap.listeners.before['event_exited']['dapui_config'] = function()
	ui.close()
end

ui.setup {
	icons = {
		expanded = '⯆',
		collapsed = '⯈'
	},
	mappings = {
		expand = {'<CR>', '<LeftMouse>'},
		open = {'o'},
		remove = {'d', 'x'},
		edit = {'i', 'a'},
		repl = {'r'},
	},
	sidebar = {
		elements = {
			'breakpoints',
			'watches',
			'stacks',
			'scopes',
		},
		size = 40,
		position = 'right',
	},
	tray = {
		elements = {
			'repl'
		},
		size = 10,
		position = 'bottom',
	},
	floating = {
		max_height = nil,  -- Either absolute integer or float
		max_width  = nil,  -- between 0 and 1 (size relative to screen size)
	}
}
