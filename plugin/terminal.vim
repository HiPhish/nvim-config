"   ______                    _             __
"  /_  __/__  _________ ___  (_)___  ____ _/ /
"   / / / _ \/ ___/ __ `__ \/ / __ \/ __ `/ / 
"  / / /  __/ /  / / / / / / / / / / /_/ / /  
" /_/  \___/_/  /_/ /_/ /_/_/_/ /_/\__,_/_/   
"                                           __  __  _                 
"                                ________  / /_/ /_(_)___  ____ ______
" Settings for the built-in     / ___/ _ \/ __/ __/ / __ \/ __ `/ ___/
" terminal emulator            (__  )  __/ /_/ /_/ / / / / /_/ (__  ) 
"                             /____/\___/\__/\__/_/_/ /_/\__, /____/  
"                                                       /____/        
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


" An alternative terminal command, opens the terminal in a new window
command! -bang -nargs=? -complete=shellcmd Terminal call <SID>term(<q-bang>, <q-mods>, <q-args>)

function! s:term(bang, mods, args)
	if empty(a:bang)
		execute a:mods 'new'
	endif
	execute 'terminal' a:args
	normal! G$a
endfunction
