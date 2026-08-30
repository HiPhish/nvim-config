" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: Unlicense

" Recognise header files as C rather than C++; use 'hpp' for C++ instead.
autocmd! BufRead,BufNewFile *.h  setfiletype c
