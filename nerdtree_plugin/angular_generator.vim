function! s:is_ng_project()
	return filereadable('angular.json')
endfunction

let s:ng_menu = NERDTreeAddSubmenu({
	\ 'text': 'An(g)ular Generator',
	\ 'shortcut': 'g',
	\ 'isActiveCallback': function('s:is_ng_project'),
\ })

let s:items = [
	\ ['(c)omponent', 'c', 'component'],
	\ ['(d)irective', 'd', 'directive'],
	\ ['(g)uard'    , 'g', 'guard'    ],
	\ ['(m)odule'   , 'm', 'module'   ],
	\ ['(p)ipe'     , 'p', 'pipe'     ],
	\ ['(s)ervice'  , 's', 'service'  ],
\ ]

for [s:text, s:shortcut, s:name] in s:items
	let s:callback = printf('nerdtree#angular#generator#%s#create', s:name)
	call NERDTreeAddMenuItem({
		\ 'parent': s:ng_menu,
		\ 'text': s:text,
		\ 'shortcut': s:shortcut,
		\ 'callback': function(s:callback)
	\ })
endfor
