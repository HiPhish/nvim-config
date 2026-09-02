" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: 0BSD

" folding regions
syn region dash_block start='\v^\/\*\+(\[.*\])?-*\*\/$' end='\v^\/\*-(\[.*\])?-*\*\/$' fold contained transparent

syn region asdf_block start='\v^\*a' end="hjkl" fold transparent
