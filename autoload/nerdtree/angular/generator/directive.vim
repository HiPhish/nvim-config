let s:template =<< EOF
import { Directive } from '@angular/core';

@Directive({
	selector: '[app%s]'
})
export class %sDirective {

	constructor() { }

}
EOF

function! s:make_content(name)
	let l:Name = nerdtree#angular#generator#snake_kebab_to_Camel(a:name)
	return printf(join(s:template, "\n"), l:Name, l:Name)
endfunction

function! s:generator(path, name)
	return [[ a:path .. a:name .. '.directive.ts', s:make_content(a:name)]]
endfunction

function! nerdtree#angular#generator#directive#create()
	call nerdtree#angular#generator#create('Directive', 'my-directive', function('s:generator'))
endfunction
