" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: 0BSD

syntax match    zathuraComment  '\v#.*$'                 contains=@Spell

syntax match    zathuraInt      '\v\d+'
syntax match    zathuraFloat    '\v\d+\.\d+'
syntax match    zathuraString   '\v"([^\"]|\\"|\\\w)*"'  contains=@Spell
syntax keyword  zathuraBoolean  true false

syntax keyword  zathuraCommand  set include map



" =============================================================================
highlight link zathuraComment   Comment
highlight link zathuraInt       Number
highlight link zathuraFloat     Number
highlight link zathuraString    String
highlight link zathuraBoolean   Boolean
highlight link zathuraCommand   Keyword
