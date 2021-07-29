let s:slash = nerdtree#slash()


" =============================================================================
let s:component_ts_template =<< EOF
import { Component, OnInit } from '@angular/core';

@Component({
	selector: 'app-%s',
	templateUrl: './%s.component.html',
	styleUrls: ['./%s.component.css'],
})
export class %sComponent implements OnInit {

	constructor() { }

	ngOnInit() {
	}
}
EOF

let s:component_html_template =<< EOF
<p>
	%s works
</p>
EOF

let s:service_tempate =<< EOF
import { Injectable } from '@angular/core';

@Injectable()
export class %sService {

	constructor() { }

}
EOF

let s:directive_template =<< EOF
import { Directive } from '@angular/core';

@Directive({
	selector: '[app%s]'
})
export class %sDirective {

	constructor() { }

}
EOF

let s:module_template =<< EOF
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

let s:pipe_template =<< EOF
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

let s:guard_template =<< EOF
import { Injectable } from '@angular/core';
import { CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { Observable } from 'rxjs';

@Injectable()
export class %sGuard implements CanActivate {
	canActivate(
		next: ActivatedRouteSnapshot,
		state: RouterStateSnapshot): Observable<boolean> | Promise<boolean> | boolean {
		return true;
	}
}
EOF


" =============================================================================
function! s:snake_kebab_to_Camel(s)
	return toupper(a:s[0]) .. substitute(a:s[1:], '\v\[-_](\a)', '\u\1', 'g')
endfunction

function s:make_component_ts_content(name)
	let l:Name = s:snake_kebab_to_Camel(a:name)
	return printf(join(s:component_ts_template, "\n"), a:name, a:name, a:name, l:Name)
endfunction

function s:make_component_html_content(name)
	return printf(join(s:component_html_template, "\n"), a:name)
endfunction

function! s:make_service_content(name)
	return printf(join(s:service_tempate, "\n"), s:snake_kebab_to_Camel(a:name))
endfunction

function! s:make_directive_content(name)
	let l:Name = s:snake_kebab_to_Camel(a:name)
	return printf(join(s:directive_tempate, "\n"), l:Name, l:Name)
endfunction

function! s:make_module_content(name)
	let l:Name = s:snake_kebab_to_Camel(a:name)
	return printf(join(s:module_tempate, "\n"), l:Name)
endfunction

function! s:make_pipe_content(name)
	let l:Name = s:snake_kebab_to_Camel(a:name)
	return printf(join(s:pipe_tempate, "\n"), a:name, l:Name)
endfunction

function! s:make_guard_content(name)
	let l:Name = s:snake_kebab_to_Camel(a:name)
	return printf(join(s:guard_tempate, "\n"), l:Name)
endfunction


" =============================================================================
function! s:component_files(path, name)
	return [
		\ [a:path .. a:name .. s:slash .. a:name .. '.component.ts', s:make_component_ts_content(a:name)],
		\ [a:path .. a:name .. s:slash .. a:name .. '.component.html', s:make_component_html_content(a:name)],
		\ [a:path .. a:name .. s:slash .. a:name .. '.component.css', ''],
	\ ]
endfunction

function! s:service_files(path, name)
	return [
		\ [
			\ a:path .. a:name .. '.service.ts',
			\ s:make_service_content(a:name)
		\ ],
	\ ]
endfunction

function! s:directive_files(path, name)
	return [
		\ [
			\ a:path .. a:name .. '.directive.ts',
			\ s:make_directive_content(a:name)
		\ ],
	\ ]
endfunction

function! s:module_files(path, name)
	return [
		\ [
			\ a:path .. a:name .. s:slash .. a:name .. '.module.ts',
			\ s:make_module_content(a:name)
		\ ],
	\ ]
endfunction

function! s:pipe_files(path, name)
	return [
		\ [
			\ a:path .. a:name .. '.pipe.ts', \ s:make_pipe_content(a:name)
		\ ],
	\ ]
endfunction

function! s:guard_files(path, name)
	return [
		\ [
			\ a:path .. a:name .. '.guard.ts', \ s:make_guard_content(a:name)
		\ ],
	\ ]
endfunction


" =============================================================================
function! s:create_node(path, content)
	echom a:path
	let l:new_path = g:NERDTreePath.Create(a:path)
	let l:parent_node = b:NERDTree.root.findNode(l:new_path.getParent())

	let l:new_node = g:NERDTreeFileNode.New(l:new_path, b:NERDTree)

	" Emptying g:NERDTreeOldSortOrder forces the sort to recalculate the
	" cached sortKey so nodes sort correctly.
	let g:NERDTreeOldSortOrder = []
	if empty(l:parent_node)
		call b:NERDTree.root.refresh()
		call b:NERDTree.render()
	elseif l:parent_node.isOpen || !empty(l:parent_node.children)
		call l:parentNode.add_child(l:new_node, 1)
		call NERDTreeRender()
		call l:new_node.putCursorHere(1, 0)
	endif

	call writefile(split(a:content, "\n"), a:path, 's')
endfunction

function! nerdtree#angular#component#create()
	let l:path = g:NERDTreeDirNode.GetSelected().path.str() .. s:slash
	let l:name = input('Component name: ', 'my-component')

	if l:name == ''
		call nerdtree#echo('Component creation aborted.')
	endif

	let l:files = s:module_files(l:path, l:name)

	try
		for [l:path, l:content] in l:files
			call s:create_node(l:path, l:content)
		endfor
		redraw!
	catch /^NERDTree/
		call nerdtree#warning('Module not created')
	endtry
	
	redraw!
endfunction
