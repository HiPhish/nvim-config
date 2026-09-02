" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: 0BSD

" Recognise header files as C rather than C++; use 'hpp' for C++ instead.
autocmd! BufRead,BufNewFile *.h  setfiletype c
