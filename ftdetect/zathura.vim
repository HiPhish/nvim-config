" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: 0BSD

augroup	filetypedetect
	au! BufRead,BufNewFile zathurarc,*.zathura setfiletype zathura
augroup END
