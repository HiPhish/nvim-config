let s:template =<< EOF
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

@NgModule({
	imports: [
		CommonModule
	],
	declarations: []
})
export class %sModule { }
EOF

function! s:make_content(name)
	let l:Name = nerdtree#angular#generator#snake_kebab_to_Camel(a:name)
	return printf(join(s:template, "\n"), l:Name)
endfunction

function! s:generator(path, name)
	return [
		\ [
			\ a:path .. a:name .. nerdtree#slash() .. a:name .. '.module.ts',
			\ s:make_content(a:name)
		\ ],
	\ ]
endfunction

function! nerdtree#angular#generator#module#create()
	call nerdtree#angular#generator#create('Module', 'my-module', function('s:generator'))
endfunction
