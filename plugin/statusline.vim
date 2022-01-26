augroup StatusLine
au!
au WinEnter,BufEnter * setlocal statusline=%{%luaeval('require(\"hiphish.statusline\").get(\"active\")')%}
au WinLeave,BufLeave * setlocal statusline=%{%luaeval('require(\"hiphish.statusline\").get(\"inactive\")')%}
augroup END
