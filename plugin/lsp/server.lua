-- This file contains all the LSP server configurations


--- [ Ansible ]----------------------------------------------------------------
vim.lsp.enable 'ansiblels'


--- [ ASTRO ]----------------------------------------------------------------
vim.lsp.enable 'astro'


--- [ CLANGD ]-----------------------------------------------------------------
vim.lsp.enable 'clangd'


--- [ CSS ]--------------------------------------------------------------------
vim.lsp.enable 'some-sass'


--- [ DOCKERFILE LS NODEJS ]---------------------------------------------------
vim.lsp.enable 'dockerls'


--- [ ELIXIR LS ]--------------------------------------------------------------
vim.lsp.enable 'elixirls'


--- [ FENNEL_LS ]--------------------------------------------------------------
-- vim.lsp.enable 'fennel_ls'


--- [ HTML ]-------------------------------------------------------------------
vim.lsp.enable 'html'


--- [ JSON ]-------------------------------------------------------------------
vim.lsp.enable 'jsonls'


--- [ LUA LANGUAGE SERVER ]----------------------------------------------------
vim.lsp.config('lua_ls', {
	settings = require('hiphish.lsp.lua_ls.rules').apply(),
})
vim.lsp.enable 'lua_ls'


--- [ PYTHON LSP SERVER ]------------------------------------------------------
vim.lsp.config('pylsp', {
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
})
vim.lsp.enable 'pylsp'


--- [ QMLLS ]------------------------------------------------------------------
vim.lsp.config('qmlls', {
	cmd = {'/usr/lib/qt6/bin/qmlls'},
})
vim.lsp.enable 'qmlls'


--- [ TAILWIND CSS ]-----------------------------------------------------------
vim.lsp.enable('tailwindcss')


--- [ TS_LS ] -----------------------------------------------------------------
vim.lsp.enable 'ts_ls'


--- [ TYPST ] -----------------------------------------------------------------
vim.lsp.enable 'tinymist'


--- [ VALA LANGUAGE SERVER ] --------------------------------------------------
vim.lsp.enable 'vala_ls'


--- [ YAML LANGUAGE SERVER ]--------------------------------------------------
vim.lsp.enable 'yamlls'
