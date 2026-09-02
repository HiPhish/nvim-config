" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: 0BSD

syntax match recutilsComment    '\v^#.*$'
syntax match recutilsNewline    '\v\zs^\+ ?\ze.+'
syntax match recutilsSpecial    '\v^\zs\%[a-zA-Z%][a-zA-Z0-9_]*\ze:\s'
syntax match recutilsFieldName  '\v^\zs[a-zA-Z][a-zA-Z0-9_]*\ze:\s'
syntax match recutilsFieldValue '\v^[a-zA-Z%][a-zA-Z0-9_]*:\s\zs.*\ze\n'


" =============================================================================
highlight link recutilsComment   Comment
highlight link recutilsNewline   Comment
highlight link recutilsSpecial   Special
highlight link recutilsFieldName Type
