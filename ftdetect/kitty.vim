" License:  The MIT License (MIT) {{{
"    Copyright (c) 2019 HiPhish
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

" Detect Kitty terminal emulator configuration files
autocmd! BufRead,BufNewFile *.conf call s:adjustFileType()

function! s:adjustFileType()
	if s:detectKittyConfDirectory(getcwd())
		if empty(&ft)
			setfiletype conf.kitty
		else
			execute 'setfiletype ' . &ft . '.kitty'
		endif
	endif
endfunction

" Detect whether this configuration file belongs to Kitty. It returns true if
" the current working directory matches one of the known configuration
" directories of Kitty.
function! s:detectKittyConfDirectory(dir)
	" Check all known Kitty configuration directories. Note: when adding new
	" checks sort them by likelihood and performance cost; the sooner we hit a
	" positive, the soon the function returns, which improves startup time.
	if a:dir == $HOME . '/.config/kitty' || a:dir == '/etc/xdg/kitty'
		return v:true
	elseif exists('$XDG_CONFIG_HOME') && a:dir == $XDG_CONFIG_HOME . '/kitty'
		return v:true
	elseif exists('$KITTY_CONFIG_DIRECTORY') && a:dir == $KITTY_CONFIG_DIRECTORY
		return v:true
	elseif exists('$XDG_CONFIG_DIRS')
		for l:dir in split($XDG_CONFIG_DIRS, ':')
			if a:dir == l:dir
				return true
			endif
		endfor
	endif

	return v:false
endfunction

" NOTE: We are not checking the directory which can be passed through the
" '--config' option to Kitty. For this we would have to detect that Vim is
" running within a Kitty instance and then try to get the name of this
" directory from Kitty. To my knowledge Kitty has no way of getting this value
" though.
