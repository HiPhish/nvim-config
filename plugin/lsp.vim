" Language Server Protocol configuration

" The following settings only apply when not using the built-in LSP client
if has('nvim-0.5.0')
	finish
endif


" ===[ C family ]==============================================================
autocmd User lsp_setup call lsp#register_server({
	\ 'name': 'clangd',
	\ 'cmd': [
		\ 'clangd',
		\ '-mwarn-sign-mismatch',
		\ '-mwarn-missing-parenthesis'
	\ ],
	\ 'whitelist': ['c', 'cpp', 'objc', 'objcpp']
\ })


" ===[ Java ]==================================================================
let s:eclipse_jdt_ls_args = [
		\ 'java',
		\ '-Declipse.application=org.eclipse.jdt.ls.core.id1',
		\ '-Dosgi.bundles.defaultStartLevel=4',
		\ '-Declipse.product=org.eclipse.jdt.ls.core.product',
		\ '-Dlog.level=ALL',
		\ '-noverify',
		\ '-Xmx1G',
		\ '-jar',
		\ expand('~/.bin/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.*.jar'),
		\ '-configuration',
		\ expand('~/.bin/eclipse.jdt.ls/config_linux'),
		\ '-data',
		\ expand('~/.local/share/eclipse/workspace/').fnamemodify(getcwd(), ':t'),
	\ ]
if exists('$JAVA_HOME') && matchstr($JAVA_HOME, '\v\d+$') != '8'
	call extend(s:eclipse_jdt_ls_args, [
		\ '--add-modules=ALL-SYSTEM',
		\ '--add-opens',
		\ 'java.base/java.util=ALL-UNNAMED',
		\ '--add-opens',
		\ 'java.base/java.lang=ALL-UNNAMED'
	\ ])
endif

autocmd User lsp_setup call lsp#register_server({
	\ 'name': 'eclipse.jdt.ls',
	\ 'cmd': s:eclipse_jdt_ls_args,
	\ 'whitelist': ['java'],
\ })
