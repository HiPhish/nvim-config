augroup StatusLine
au!
au WinEnter,BufEnter * setl stl=%{%luaeval('require(\"hiphish.statusline\").get(\"active\")')%}
au WinLeave,BufLeave * setl stl=%{%luaeval('require(\"hiphish.statusline\").get(\"inactive\")')%}
augroup END
