"     _                  
"    | | __ ___   ____ _ 
" _  | |/ _` \ \ / / _` |
"| |_| | (_| |\ V / (_| |
" \___/ \__,_| \_/ \__,_|


if filereadable('build.gradle')
	setlocal makeprg=gradle
endif

let g:LanguageClient_serverCommands['java'] = ['sh', '~/.bin/java-lsp.sh']
nnoremap gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <F2> :call LanguageClient#textDocument_rename()<CR>
