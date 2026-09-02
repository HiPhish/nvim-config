" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: 0BSD

" Add the target language of the PO file to the spelling languages if it is
" not yet part of the setting.  We assume that the PO file follows standard
" gettext file location rules.  This means it will be located under a path
" like 'foo/bar/baz/<locale>/LC_MESSAGES/derp.po'
let s:fname = expand('%')
if fnamemodify(s:fname, ':e') == 'po'  |" Skip POT files
	let s:spelllang = matchstr(fnamemodify(s:fname, ':h:h:t'), '\v^[[:lower:]]{2}\ze(_[[:upper:]]{2})?$')
	if indexof(split(&spelllang, ','), {_, v -> v == s:spelllang}) < 0
		let &l:spelllang = printf('%s,%s', &spelllang, s:spelllang)
	endif
endif
