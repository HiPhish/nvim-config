"     _                  
"    | | __ ___   ____ _ 
" _  | |/ _` \ \ / / _` |
"| |_| | (_| |\ V / (_| |
" \___/ \__,_| \_/ \__,_|


if filereadable('build.gradle')
	set makeprg=gradle
	if executable('./gradlew')
		set makeprg=./gradlew
	endif
endif

" A makefile takes precedence over Gradle because it is likely to contain
" special individual settings on top of the project's Gradle settings.
if filereadable('makefile') || filereadable('Makefile')
	set makeprg=make
endif

" LanguageClient Neovim settings
nnoremap <buffer> <silent> gd    :call LanguageClient#textDocument_definition()<CR>
nnoremap <buffer> <silent> <C-S> :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <buffer> <silent> <F2>  :call LanguageClient#textDocument_rename()<CR>
nnoremap <buffer> <silent> K     :call LanguageClient#textDocument_hover()<CR>
