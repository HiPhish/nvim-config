" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: 0BSD

autocmd! BufRead,BufNewFile *.html  set ft=html | call jinja#AdjustFiletype()
