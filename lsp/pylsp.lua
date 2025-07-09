return {
	cmd = {'pylsp'},
	filetypes = {'python'},
	root_markers = {
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        'Pipfile',
	},
	settings = {
		-- https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
		pylsp = {
			plugins = {
				-- If this plugin does not work try running MyPy from the
				-- command line first
				pylsp_mypy = {
					enabled = vim.fn.executable('mypy'),
					live_mode = true,
				},
				-- This used to be too slow the last time I tried it
				rope_autoimport = {
					enabled = false,
					completions = {
						enabled = false,
					},
					code_actions = {
						enabled = false,
					}
				},
				ruff = {
					enabled = vim.fn.executable('ruff'),
					extendSelect = {'I'}
				},
				black = {
					enabled = vim.fn.executable('black'),
				}
			},
		},
	},
}
