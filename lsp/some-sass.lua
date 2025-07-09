-- https://github.com/wkillerud/some-sass
--
--
return {
	cmd = {'some-sass-language-server', '--stdio'},
	filetypes = { 'scss', 'sass', 'css' },
	root_markers = {'package.json', '.package.json', '.git'},
	settings = {
		somesass = {
			suggestAllFromOpenDocument = true,
			-- workspace = {
			-- 	loadPaths = {'node_modules'}
			-- }
		}
	}
}
