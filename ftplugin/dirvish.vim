" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: 0BSD

" Remove hidden files from the buffer
silent keeppatterns global@\v/\.[^\/]+/?$@d

setlocal nospell
