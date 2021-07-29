let s:slash = nerdtree#slash()

let s:ts_template =<< EOF
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

let s:html_template =<< EOF
<p>
	%s works
</p>
EOF

function s:make_ts_content(name)
	let l:Name = nerdtree#angular#generator#snake_kebab_to_Camel(a:name)
	return printf(join(s:ts_template, "\n"), a:name, a:name, a:name, l:Name)
endfunction

function s:make_html_content(name)
	return printf(join(s:html_template, "\n"), a:name)
endfunction

function! s:generator(path, name)
	return [
		\ [a:path .. a:name .. s:slash .. a:name .. '.component.ts', s:make_ts_content(a:name)],
		\ [a:path .. a:name .. s:slash .. a:name .. '.component.html', s:make_html_content(a:name)],
		\ [a:path .. a:name .. s:slash .. a:name .. '.component.css', ''],
	\ ]
endfunction

function! nerdtree#angular#generator#component#create()
	call nerdtree#angular#generator#create('Component', 'my-component', function('s:generator'))
endfunction
