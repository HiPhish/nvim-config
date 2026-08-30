" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: Unlicense

autocmd! BufRead,BufNewFile *.html  set ft=html | call jinja#AdjustFiletype()
