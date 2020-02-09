func! ncm2#on_complete#lsp(context)
	lua ncm2 = require("ncm2")
	call v:lua.ncm2.on_complete_lsp(a:context)
endfunc
