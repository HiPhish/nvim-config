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

let g:LanguageClient_serverCommands['java'] = ['sh', '~/.bin/java-lsp.sh']
nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<CR>
