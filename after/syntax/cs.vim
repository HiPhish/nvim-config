" Override the weird setting set by the official syntax file; without this
" everything will be spell-checked. The reason this is on is because the C#
" syntax file sources the XML syntax file (because of embedded XML
" documentation comments), and the XML syntax file sets syntax spell checking
" to toplevel.
syntax spell default
