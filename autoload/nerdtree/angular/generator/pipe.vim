let s:template =<< EOF
import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
	name: '%s'
})
export class %sPipe implements PipeTransform {

	transform(value: any, args?: any): any {
		return null;
	}

}
EOF

function! s:make_content(name)
	let l:Name = nerdtree#angular#generator#snake_kebab_to_Camel(a:name)
	return printf(join(s:pipe_template, "\n"), a:name, l:Name)
endfunction

function! s:generator(path, name)
	return [[a:path .. a:name .. '.pipe.ts', \ s:make_content(a:name)]]
endfunction

function! nerdtree#angular#generator#pipe#create()
	call nerdtree#angular#generator#create('Pipe', 'my-pipe', function('s:generator'))
endfunction
