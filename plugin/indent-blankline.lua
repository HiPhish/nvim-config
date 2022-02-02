local settings = {
	filetype = {'python', 'nim'},
	enabled = true,
	char = '│',
	space_char = ' ',
	space_char_blankline = ' ',
	show_current_context = true,
	context_patterns = {
		'class', 'function', 'def', 'method', '^if', '^elif', '^else', '^for',
		'^with', '^while', '^until', '^try', '^except', '^finally'
	},
	context_highlight_list = {
		'RainbowRed', 'RainbowYellow', 'RainbowBlue', 'RainbowGreen',
		'RainbowCyan', 'RainbowOrange', 'RainbowViolet'
	},
}
settings.space_char_blankline_highlight_list = settings.context_highlight_list

require('indent_blankline').setup(settings)
