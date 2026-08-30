" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: Unlicense

" folding regions
syn region dash_block start='\v^\/\*\+(\[.*\])?-*\*\/$' end='\v^\/\*-(\[.*\])?-*\*\/$' fold contained transparent

syn region asdf_block start='\v^\*a' end="hjkl" fold transparent
