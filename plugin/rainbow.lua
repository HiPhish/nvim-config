-- Settings used by the plugin luochen1990/rainbow
vim.g.rainbow_active = 1

local html_tags = 'area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr'
local jinja_statements = 'if|for|raw|block|macro|call|filter|trans|with|autoescape'
local guifgs= {
	'RainbowRed',
	'RainbowYellow',
	'RainbowBlue',
	'RainbowGreen',
	'RainbowCyan',
	'RainbowOrange',
	'RainbowViolet'
}

--- Map a highlight group to hex value of its foreground colour.
local function hl_to_fg_hex(hl)
	local syn_id = vim.fn.hlID(hl)
	local t_syn_id = vim.fn.synIDtrans(syn_id)
	return vim.fn.synIDattr(t_syn_id, 'fg#')
end

vim.g.rainbow_conf = {
	guifgs = vim.tbl_map(hl_to_fg_hex, guifgs),
	ctermfgs = {'2', '4', '3', '9', '4', '1', '14', '5', '11', '13', '12'},
	operators = '_,_',
	parentheses = {
		[[start=/(/ end=/)/ fold]],
		[[start=/\[/ end=/\]/ fold]],
		[[start=/{/ end=/}/ fol]],
	},
	separately = {
		['*'] = 0,
		lisp = {
			parentheses = {
				[[start=/\m['`,#@]*(/ end=/\m)/]]
			},
			operators = ''
		},
		racket = {
			parentheses = {
				[[start=/\m['`,#@]*(/ end=/\m)/]],
				[[start=/\v['`,#@]*\[/ end=/\v\]/]]
			},
			operators = ''
		},
		scheme = {
			parentheses = {
				[[start=/\m['`,#@]*(/ end=/\m)/]],
				[[start=/\v['`,#@]*\[/ end=/\v\]/]]
			},
			operators = ''
		},
		vim = {
			parentheses = {
				[[start=/(/ end=/)/]],
				[[start=/\[/ end=/\]/]],
				[[start=/{/ end=/}/ fold]],
				[[start=/(/ end=/)/ containedin=vimFuncBody]],
				[[start=/\[/ end=/\]/ containedin=vimFuncBody]],
				[[start=/{/ end=/}/ fold containedin=vimFuncBody]]
			},
		},
		html = {
			parentheses = {
				[[start=/\v\<((]].. html_tags ..[[)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'[^']*'|[^ '"><=`]*))?)*\>/ end=#</\z1># fold]]
			},
		},
		jinja = {
			-- Some Jinja statements also have in-between elements:
			--   if     elif, else
			--   for    else, continue, break
			--   trans  pluralize
			parentheses = {
				[[start=/\v\{\%\-?\+?\s*\z(]].. jinja_statements .. [[).*\s*\-?\+?\%\}/ step=/\v\{\%\-?\+?\s*else\s*\-?\+?\%\}/ end=/\v\{\%\-?\+?\s*end\z1(\s+\w+)?\s*\-?\+?\%\}/]]
			}
		},
		css = 0,
	},
}
