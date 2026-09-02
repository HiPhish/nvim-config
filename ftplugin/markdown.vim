" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: 0BSD

setlocal textwidth=79
" Use spaces instead of tabs
setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
" Do not hide any characters
setlocal conceallevel=0

" Change some settings for special Markdown buffers. These buffers are usually
" created by Vim to be read by a person, not to be edited. For such buffers
" the following settings are easier on the eyes when reading.
if &buftype =~ 'nofile'
	setlocal nospell conceallevel=2 concealcursor=nc
endif
