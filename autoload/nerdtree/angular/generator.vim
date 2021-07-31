" Create one or more Angular files.
"
" {thing}: String of human-readable name of the type of Angular file(s)
" {name}: String name of the thing to create (supplied by user)
" {Generator}: function to call to generate list of file names and contents
function! nerdtree#angular#generator#create(thing, name, Generator) abort
	let l:path = g:NERDTreeDirNode.GetSelected().path.str() .. nerdtree#slash()
	let l:name = input(printf('Angular %s name: ', a:thing), a:name)

	if l:name == ''
		let l:msg = printf('Angular %s creation aborted', a:thing)
		call nerdtree#echoWarning(l:msg)
		return
	endif

	let l:files = a:Generator(l:path, l:name)

	try
		for [l:path, l:content] in l:files
			call s:create_node(l:path, l:content)
		endfor
		redraw!
	catch /^NERDTree/
		let l:msg = printf('Angular %s not created: %s', a:thing, v:exception)
		call nerdtree#echoError(l:msg)
		return
	endtry
	
	redraw!
endfunction

" Handy function to convert strings to CamelCase
function! nerdtree#angular#generator#snake_kebab_to_Camel(s)
	return toupper(a:s[0]) .. substitute(a:s[1:], '\v[-_](\a)', '\u\1', 'g')
endfunction

" This code is mostly copy-pasted from the NERDTree code for adding new nodes
function! s:create_node(path, content) abort
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
		call l:parent_node.addChild(l:new_node, 1)
		call NERDTreeRender()
		call l:new_node.putCursorHere(1, 0)
	endif

	call writefile(split(a:content, "\n"), a:path, 's')
endfunction
