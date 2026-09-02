" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: 0BSD

" Use explicit spell checking only in certain syntax items. Otherwise
" everything or nothing will be spell-checked.
syntax clear schemeString
syn region schemeString start=/\v(\\)@<!"/ skip=/\\[\\"]/ end=/"/ contains=@Spell
syn match schemeComment /;.*$/ contains=@Spell
