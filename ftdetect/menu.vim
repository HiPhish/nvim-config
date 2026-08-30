" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: Unlicense

" XDG Menu items definition
augroup	filetypedetect
	au! BufRead,BufNewFile *.menu setfiletype xml
augroup END
