-- https://sr.ht/~xerool/fennel-ls/
--
-- fennel-ls is configured using the closest file to your working directory
-- named `flsproject.fnl`.  All fennel-ls configuration options [can be found
-- here](https://git.sr.ht/~xerool/fennel-ls/tree/HEAD/docs/manual.md#configuration).
return {
	cmd = {'fennel-ls'},
	root_markers = {'flsproject.fnl', '.git'},
	capabilities = {
		offsetEncoding = { 'utf-8', 'utf-16' },
	},
}
