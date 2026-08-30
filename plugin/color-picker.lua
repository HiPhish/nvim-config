-- SPDX-FileCopyrightText: © 2023 HiPhish
-- SPDX-License-Identifier: Unlicense

local success, color_picker = pcall(require, 'color-picker')
if not success then return end

vim.keymap.set('n', '<C-c>', '<CMD>PickColor<CR>', {noremap=true, silent=true})
vim.keymap.set('i', '<C-c>', '<CMD>PickColorInsert<CR>', {noremap=true, silent=true})

color_picker.setup {
	icons = {'█', '▒'}
}
