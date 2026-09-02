" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: 0BSD

" Use spaces for everything
setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" Everything, except parentheses, pipe, semicolon, comma, single quote, double
" quote and space
setlocal iskeyword=33-126,^(,^),^124,^;,^,,^',^`,^34

" Repl settings
call repl#define_repl('lisp', {'bin': 'sbcl', 'args': ['--linedit']}, 'force')
