" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: Unlicense

" Use explicit spell checking only in certain syntax items. Otherwise
" everything or nothing will be spell-checked.
syntax clear jpropertiesString jpropertiesComment
syn region jpropertiesString start="" skip="\\$" end="$" contained contains=jpropertiesSpecialChar,jpropertiesError,jpropertiesSpecial,@Spell
syn match  jpropertiesComment "^\s*[#!].*$" contains=jpropertiesTODO,@Spell
