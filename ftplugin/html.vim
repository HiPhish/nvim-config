" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: 0BSD

" Apparently other file types also source this one. HTML-only settings go
" below this check
if &ft != 'html' | finish | endif

runtime ftplugin/xml.vim
