" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: Unlicense

augroup	filetypedetect
	au! BufRead,BufNewFile zathurarc,*.zathura setfiletype zathura
augroup END
