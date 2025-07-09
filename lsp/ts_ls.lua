--- https://github.com/typescript-language-server/typescript-language-server

local util = require 'lspconfig.util'
return {
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
    },
    root_markers = {'tsconfig.json', 'jsconfig.json', 'package.json', '.git'},
    single_file_support = true,
}
