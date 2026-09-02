" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: 0BSD

" XDG Menu items definition
augroup	filetypedetect
	au! BufRead,BufNewFile *.menu setfiletype xml
augroup END
