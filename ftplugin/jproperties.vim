" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: 0BSD

" Try extracting the name of the locale from the file name: if the file name
" ends in '_xx.properties', then the 'xx' is the name of the locale
let s:locale = matchstr(expand('%'), '\v_\zs\a\a\ze\.properties$')
if !empty(s:locale)
	let &l:spelllang = s:locale
endif
