-- SPDX-FileCopyrightText: © 2022 HiPhish
-- SPDX-License-Identifier: Unlicense

-- Settings for Neovim's diagnostic framework, see :h diagnostic.txt


--- [ HIGHLIGHT AND SIGNS ] ---------------------------------------------------
vim.fn.sign_define {
	{name='DiagnosticSignError', text='', texthl='DiagnosticSignError', linehl='', numhl=''},
	{name='DiagnosticSignWarn' , text='' , texthl='DiagnosticSignWarn' , linehl='', numhl=''},
	{name='DiagnosticSignInfo' , text='' , texthl='DiagnosticSignInfo' , linehl='', numhl=''},
	{name='DiagnosticSignHint' , text='', texthl='DiagnosticSignHint' , linehl='', numhl=''},
}


--- [ KEY MAPPINGS ]-----------------------------------------------------------
local function open_float()
	vim.diagnostic.open_float {border = 'rounded'}
end
vim.keymap.set('n', 'g?', open_float, {silent = true})
