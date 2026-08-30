" SPDX-FileCopyrightText: © 2019 HiPhish
" SPDX-License-Identifier: Unlicense

" Rofi Advanced Style Information


" ---[ Types ]-----------------------------------------------------------------
" Comment
syntax match  rasiLineComment '\v\/\/.*' contains=@Spell
syntax region rasiComment start='\v\/\*' end='\v\*\/' contains=@Spell

" String
syntax region rasiString  start='\v"' skip='\v\\"' end='\v"'

" Number (with optional units)
syntax match rasiNumber '\v[+-]?\d+(\.\d+)?(px|em|ch|\%)?'

" Boolean
syntax keyword rasiBoolean true
syntax keyword rasiBoolean false

" Color
syntax match rasiColor '\v\#\x{3,4}'
syntax match rasiColor '\v\#\x{6}'
syntax match rasiColor '\v\#\x{8}'
syntax match rasiColor '\vrgb(\d)'
" TODO: support rgb, rgba, hsl, hsla, hwb, hwba, cmyk and named colours
" example: rgb(9, 57, 180)
syntax keyword rasiColor AliceBlue  AntiqueWhite  Aqua  Aquamarine Azure Beige 
syntax keyword rasiColor Bisque Black BlanchedAlmond Blue BlueViolet Brown
syntax keyword rasiColor BurlyWood CadetBlue Chartreuse Chocolate Coral 
syntax keyword rasiColor CornflowerBlue Cornsilk Crimson Cyan DarkBlue DarkCyan
syntax keyword rasiColor DarkGoldenRod DarkGray DarkGrey DarkGreen DarkKhaki
syntax keyword rasiColor DarkMagenta DarkOliveGreen DarkOrange DarkOrchid
syntax keyword rasiColor DarkRed DarkSalmon DarkSeaGreen DarkSlateBlue
syntax keyword rasiColor DarkSlateGray DarkSlateGrey DarkTurquoise DarkViolet
syntax keyword rasiColor DeepPink DeepSkyBlue DimGray DimGrey DodgerBlue
syntax keyword rasiColor FireBrick FloralWhite ForestGreen Fuchsia Gainsboro
syntax keyword rasiColor GhostWhite Gold GoldenRod Gray Grey Green GreenYellow
syntax keyword rasiColor HoneyDew HotPink IndianRed Indigo Ivory Khaki Lavender
syntax keyword rasiColor LavenderBlush LawnGreen LemonChiffon LightBlue
syntax keyword rasiColor LightCoral LightCyan LightGoldenRodYellow LightGray
syntax keyword rasiColor LightGrey LightGreen LightPink LightSalmon
syntax keyword rasiColor LightSeaGreen LightSkyBlue LightSlateGray
syntax keyword rasiColor LightSlateGrey LightSteelBlue LightYellow Lime
syntax keyword rasiColor LimeGreen Linen Magenta Maroon MediumAquaMarine
syntax keyword rasiColor MediumBlue MediumOrchid MediumPurple MediumSeaGreen
syntax keyword rasiColor MediumSlateBlue MediumSpringGreen MediumTurquoise
syntax keyword rasiColor MediumVioletRed MidnightBlue MintCream MistyRose
syntax keyword rasiColor Moccasin NavajoWhite Navy OldLace Olive OliveDrab
syntax keyword rasiColor Orange OrangeRed Orchid PaleGoldenRod PaleGreen
syntax keyword rasiColor PaleTurquoise PaleVioletRed PapayaWhip PeachPuff Peru
syntax keyword rasiColor Pink Plum PowderBlue Purple RebeccaPurple Red
syntax keyword rasiColor RosyBrown RoyalBlue SaddleBrown Salmon SandyBrown
syntax keyword rasiColor SeaGreen SeaShell Sienna Silver SkyBlue SlateBlue
syntax keyword rasiColor SlateGray SlateGrey Snow SpringGreen SteelBlue Tan
syntax keyword rasiColor Teal Thistle Tomato Turquoise Violet Wheat White
syntax keyword rasiColor WhiteSmoke Yellow YellowGreen transparent

" Text- and line style, orientation, inheritance
syntax keyword rasiStyle bold italic underline strikethrough none
syntax keyword rasiStyle dash solid
syntax keyword rasiStyle horizontal vertical
syntax keyword rasiStyle inherit

" References
syntax match rasiReference '\v\@\w+'


" ---[ Keywords ]--------------------------------------------------------------
" Known keywords for Rofi version 1.5.1+, sorted alphabetically
syn keyword rasiTagName auto-select bw case-sensitive click-to-exit
syn keyword rasiTagName color-active color-normal color-urgent color-window
syn keyword rasiTagName columns combi-hide-mode-prefix combi-modi cycle
syn keyword rasiTagName disable-history display-combi display-drun display-keys
syn keyword rasiTagName display-run display-ssh display-window display-windowcd
syn keyword rasiTagName dpi drun-icon-theme drun-match-fields eh fake-background
syn keyword rasiTagName fake-transparency filter fixed-num-lines font
syn keyword rasiTagName fullscreen hide-scrollbar kb-accept-alt kb-accept-custom
syn keyword rasiTagName kb-accept-entry kb-cancel kb-clear-line
syn keyword rasiTagName kb-custom-1  kb-custom-2  kb-custom-3  kb-custom-4
syn keyword rasiTagName kb-custom-5  kb-custom-6  kb-custom-7  kb-custom-8
syn keyword rasiTagName kb-custom-9  kb-custom-10 kb-custom-11 kb-custom-12
syn keyword rasiTagName kb-custom-13 kb-custom-14 kb-custom-15 kb-custom-16
syn keyword rasiTagName kb-custom-17 kb-custom-18 kb-custom-19
syn keyword rasiTagName kb-delete-entry kb-mode-next kb-mode-previous
syn keyword rasiTagName kb-move-char-back kb-move-char-forward kb-move-end
syn keyword rasiTagName kb-move-front kb-move-word-back kb-move-word-forward
syn keyword rasiTagName kb-page-next kb-page-prev kb-primary-paste
syn keyword rasiTagName kb-remove-char-back kb-remove-char-forward
syn keyword rasiTagName kb-remove-to-eol kb-remove-to-sol kb-remove-word-back
syn keyword rasiTagName kb-remove-word-forward kb-row-down kb-row-first
syn keyword rasiTagName kb-row-last kb-row-left kb-row-right kb-row-select
syn keyword rasiTagName kb-row-tab kb-row-up kb-screenshot kb-secondary-paste
syn keyword rasiTagName kb-select-1 kb-select-2 kb-select-3 kb-select-4
syn keyword rasiTagName kb-select-5 kb-select-6 kb-select-7 kb-select-8
syn keyword rasiTagName kb-select-9 kb-select-10
syn keyword rasiTagName kb-toggle-case-sensitivity kb-toggle-sort
syn keyword rasiTagName levenshtein-sort line-margin line-padding lines location
syn keyword rasiTagName m matching max-history-size me-accept-custom
syn keyword rasiTagName me-accept-entry me-select-entry ml-row-down ml-row-left
syn keyword rasiTagName ml-row-right ml-row-up modi padding parse-hosts
syn keyword rasiTagName parse-known-hosts pid syn keyword rasiTagName
syn keyword rasiTagName run-command run-list-command run-shell-command
syn keyword rasiTagName scrollbar-width scroll-method separator-style
syn keyword rasiTagName show-icons show-match sidebar-mode sort sorting-method
syn keyword rasiTagName ssh-client ssh-command terminal theme threads tokenize
syn keyword rasiTagName width window-command window-format window-match-fields
syn keyword rasiTagName xoffset yoffset


" ===[ Highlighting ]==========================================================
highlight default link rasiComment     Comment
highlight default link rasiLineComment Comment
highlight default link rasiString      String
highlight default link rasiNumber      Number
highlight default link rasiBoolean     Boolean
highlight default link rasiColor       Constant
highlight default link rasiStyle       Constant
highlight default link rasiReference   Function
highlight default link rasiTagName     Statement
