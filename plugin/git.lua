-- SPDX-FileCopyrightText: © 2023 HiPhish
-- SPDX-License-Identifier: Unlicense

-- Git integration plugins
local success, gitsigns = pcall(require, 'gitsigns')
if not success then return end

-- Disable GitGutter for now
vim.g.loaded_gitgutter = true

local map = vim.keymap.set

gitsigns.setup {
	preview_config = {
		border = 'shadow'
	},
}

map('n', '<leader>hp', gitsigns.preview_hunk)
map('n', '<leader>hb', gitsigns.blame_line)
map('n', '<leader>hs', gitsigns.stage_hunk)
map('n', '<leader>hS', gitsigns.stage_buffer)
map('n', '<leader>hr', gitsigns.undo_stage_hunk)
map('n', '<leader>hu', gitsigns.reset_hunk)
map('n', '[c', gitsigns.prev_hunk)
map('n', ']c', gitsigns.next_hunk)
