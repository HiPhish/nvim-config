" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: Unlicense

" Recutils file type detection; use file extension

augroup filetypedetect
	au! BufRead,BufNewFile *.rec setfiletype recutils
augroup END
