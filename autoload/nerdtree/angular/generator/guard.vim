let s:template =<< EOF
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

function! s:make_content(name)
	let l:Name = nerdtree#angular#generator#snake_kebab_to_Camel(a:name)
	return printf(join(s:template, "\n"), l:Name)
endfunction

function! s:generator(path, name)
	return [[a:path .. a:name .. '.guard.ts', s:make_content(a:name)]]
endfunction

function! nerdtree#angular#generator#guard#create()
	call nerdtree#angular#generator#create('guard', 'my-guard', function('s:generator'))
endfunction
