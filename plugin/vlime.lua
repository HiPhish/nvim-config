-- SPDX-FileCopyrightText: © 2022 HiPhish
-- SPDX-License-Identifier: Unlicense

-- Settings for the Nvlime plugin: https://github.com/monkoose/nvlime
vim.g.nvlime_config = {
	main_window = {position = 'bottom', size = 9},
	indent_keywords = {
		['if'] = 1,
		the = 1,
	},
	cmp = {enabled = true},
}
