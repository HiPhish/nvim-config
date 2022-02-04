-- Settings for Neovim's diagnostic framework, see :h diagnostic.txt


local api = vim.api

--- [ HIGHLIGHT AND SIGNS ] ---------------------------------------------------
vim.fn.sign_define {
	{name='DiagnosticSignError', text='⛔', texthl='DiagnosticSignError', linehl='', numhl=''},
	{name='DiagnosticSignWarn' , text='⚠️' , texthl='DiagnosticSignWarn' , linehl='', numhl=''},
	{name='DiagnosticSignInfo' , text='ℹ️' , texthl='DiagnosticSignInfo' , linehl='', numhl=''},
	{name='DiagnosticSignHint' , text='💡', texthl='DiagnosticSignHint' , linehl='', numhl=''},
}
-- vim.cmd [[
-- 	sign define DiagnosticSignError text=⛔ texthl=DiagnosticSignError linehl= numhl=
-- 	sign define DiagnosticSignWarn  text=⚠️  texthl=DiagnosticSignWarn  linehl= numhl=
-- 	sign define DiagnosticSignInfo  text=ℹ️  texthl=DiagnosticSignInfo  linehl= numhl=
-- 	sign define DiagnosticSignHint  text=💡 texthl=DiagnosticSignHint  linehl= numhl=
-- ]]


--- [ KEY MAPPINGS ]-----------------------------------------------------------
api.nvim_set_keymap('n', 'g?', '<CMD>lua require("hiphish.diagnostic").open_float()<CR>',
	{noremap = true, silent = true})
