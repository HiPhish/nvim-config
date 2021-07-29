function! nerdtree#angular#generator#create(thing, name, Generator)
	let l:path = g:NERDTreeDirNode.GetSelected().path.str() .. s:slash
	let l:name = input(printf('%s name: ', a:thing), a:name)

	if l:name == ''
		call nerdtree#echo(printf('%s creation aborted', a:thing))
	endif

	let l:files = a:Generator(l:path, l:name)

	try
		for [l:path, l:content] in l:files
			call s:create_node(l:path, l:content)
		endfor
		redraw!
	catch /^NERDTree/
		call nerdtree#warning(printf('%s not created'), a:thing)
	endtry
	
	redraw!
endfunction

function! nerdtree#angular#generator#snake_kebab_to_Camel(s)
	return toupper(a:s[0]) .. substitute(a:s[1:], '\v[-_](\a)', '\u\1', 'g')
endfunction

let s:slash = nerdtree#slash()

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
		call l:parent_node.add_child(l:new_node, 1)
		call NERDTreeRender()
		call l:new_node.putCursorHere(1, 0)
	endif

	call writefile(split(a:content, "\n"), a:path, 's')
endfunction
