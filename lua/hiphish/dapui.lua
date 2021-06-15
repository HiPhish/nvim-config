require('dapui').setup {
	icons = {
		expanded = '⯆',
		collapsed = '⯈'
	},
	mappings = {
		expand = {'<CR>', '<LeftMouse>'},
		open = {'o'},
		remove = {'d'},
		edit = {'e'}
	},
	sidebar = {
		open_on_start = true,
		elements = {
			'breakpoints',
			'watches',
			'stacks',
			'scopes',
		},
		width = 40,
		position = 'right',
	},
	tray = {
		open_on_start = true,
		elements = {
			'repl'
		},
		height = 10,
		position = 'bottom',
	},
	floating = {
		max_height = nil,  -- Either absolute integer or float
		max_width  = nil,  -- between 0 and 1 (size relative to screen size)
	}
}
