let s:template =<< EOF
import { Injectable } from '@angular/core';

@Injectable()
export class %sService {

	constructor() { }

}
EOF

function! s:make_content(name)
	let l:Name = nerdtree#angular#generator#snake_kebab_to_Camel(a:name)
	return printf(join(s:template, "\n"), l:Name)
endfunction

function! s:generator(path, name)
	return [[a:path .. a:name .. '.service.ts', s:make_content(a:name)]]
endfunction

function! nerdtree#angular#generator#service#create()
	call nerdtree#angular#generator#create('service', 'my-service', function('s:generator'))
endfunction
