" License:  The MIT License (MIT) {{{
"    Copyright (c) 2018 HiPhish
"
"    Permission is hereby granted, free of charge, to any person obtaining a
"    copy of this software and associated documentation files (the
"    "Software"), to deal in the Software without restriction, including
"    without limitation the rights to use, copy, modify, merge, publish,
"    distribute, sublicense, and/or sell copies of the Software, and to permit
"    persons to whom the Software is furnished to do so, subject to the
"    following conditions:
"
"    The above copyright notice and this permission notice shall be included
"    in all copies or substantial portions of the Software.
"
"    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
"    NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
"    DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
"    OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
"    USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
scriptencoding utf-8

" Disable syntastic for most file types
let g:syntastic_mode_map = {
	\ 'mode' : 'passive',
	\ 'active_filetypes' : ['cs']
\ }

" let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list = 1

" The only good use I have ever found for Emoji
let g:syntastic_error_symbol   = 'X '
let g:syntastic_warning_symbol = '! '
let g:syntastic_style_error_symbol = '⁉️ '
let g:syntastic_style_warning_symbol = '💩 '

" Use the same highlighting as for line numbers because it looks better with
" Emoji. Don't do this for symbols that aren't Emoji.
highlight link SyntasticErrorSign   LineNr
highlight link SyntasticWarningSign LineNr



" Neomake settings
let g:neomake_open_list  = 2
let g:neomake_verbose    = 0  " Only show error messages

" Signs using Emoji (use LineNr highlight: 🚫,⚠️  ,💡
let g:neomake_error_sign = {
	\ 'text': 'X ',
	\ 'texthl': 'Error',
\ }

let g:neomake_warning_sign = {
	\ 'text': '! ',
	\ 'texthl': 'Error',
\ }

let g:neomake_message_sign = {
	\ 'text': '? ',
	\ 'texthl': 'LineNr',
\ }

let g:neomake_informational_sign = {
	\ 'text': 'i ',
	\ 'texthl': 'LineNr',
\ }

