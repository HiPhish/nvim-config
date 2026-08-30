" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: Unlicense

" Kitty terminal emulator configurations

" This syntax file is intended to be used in addition to the syntax for the
" 'conf' file type. It augments the generic configuration file syntax with
" Kitty-specific syntax definitions. Set the file type to 'conf.kitty' to get
" both of them working at the same time.


syntax match   kittyKey     '\v^\w+\ze\s'
syntax match   kittyNumber  '\v(\+|-)?\d+(\.\d+)?(c|\%)?'
syntax keyword kittyBool    yes
syntax keyword kittyBool    no
syntax match   kittyInclude '\v\s*include\ze\s+'
syntax match   kittyLaunch  '\v\s*launch\ze\s+'
syntax match   kittyColor   '\v#\x+'


" =============================================================================
highlight link kittyKey     Identifier
highlight link kittyNumber  Number
highlight link kittyBool    Boolean
highlight link kittyInclude Include
highlight link kittyLaunch  Function
highlight link kittyColor   Number
