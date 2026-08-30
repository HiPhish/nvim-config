-- SPDX-FileCopyrightText: © 2026 HiPhish
-- SPDX-License-Identifier: Unlicense

--- List of 3rd-party plugins suitable for `vim.plug.add`.

--- Transform a `user/repo` string into a GitHub URL.
--- @param name string  The user name and repo name on a GitHub repository
local function gh(name)
	return string.format('https://github.com/%s', name)
end

--- Maps package name to post-install function.
local post_install = {
	hexokinase = function(evt)
		vim.system({'make', 'hexokinase'}, {cwd = evt.data.path})
	end
}

vim.api.nvim_create_autocmd('PackChanged', {
	callback = function (evt)
		local script = post_install[evt.data.spec.name]
		if script then script(evt) end
	end
})

return {
	---[ GENERAL PLUGINS ]-----------------------------------------------------
	gh 'tpope/vim-eunuch',         -- Unix integration
	gh 'tpope/vim-fugitive',       -- Git integration
	gh 'lewis6991/gitsigns.nvim',  -- Side bar Git symbols

	-- General dependency of many plugins. Used by telescope
	gh 'nvim-lua/plenary.nvim',
	gh 'nvim-telescope/telescope.nvim',  -- Fuzzy picker

	gh 'tpope/vim-characterize',  -- Better display of character codes

	gh 'Raimondi/delimitMate',         -- Auto-insert/manage matching delimiters
	gh 'andymass/vim-matchup',         -- Highlight delimiter pairs
	gh 'rhysd/vim-operator-surround',  -- Surround operator
	gh 'kana/vim-operator-user',       -- Dependency of the above

	gh 'dcampos/nvim-snippy',  -- Snippets support
	gh 'honza/vim-snippets',   -- Predefined snippets

	gh 'preservim/nerdtree',    -- File system drawer
	gh 'justinmk/vim-dirvish',  -- File system navigator

	{  -- Inline colour preview
		src = gh 'RRethy/vim-hexokinase',
		name = 'hexokinase',
	},

	gh 'dstein64/vim-win',  -- Window manager mode


	---[ AUTO COMPLETION ]-----------------------------------------------------
	gh 'hrsh7th/nvim-cmp',

	gh 'hrsh7th/cmp-nvim-lsp',                 -- LSP completion
	gh 'hrsh7th/cmp-nvim-lsp-signature-help',  -- Signature inside function arguments
	gh 'hrsh7th/cmp-path',                     -- Path completion
	gh 'dcampos/cmp-snippy',                   -- Snippet completion support
	gh 'rcarriga/cmp-dap',                     -- Auto-completion in DAP buffers


	---[ LANGUAGE SERVER PROTOCOL ]--------------------------------------------
	gh 'neovim/nvim-lspconfig',
	gh 'kosayoda/nvim-lightbulb',
	gh 'j-hui/fidget.nvim',         -- Progress indicator in a floating window
	gh 'SmiteshP/nvim-navic',       -- Show current code context


	---[ DEBUG ADAPTER PROTOCOL ]----------------------------------------------
	gh 'mfussenegger/nvim-dap',
	gh 'rcarriga/nvim-dap-ui',
	gh 'theHamsta/nvim-dap-virtual-text',


	---[ TREE-SITTER ]---------------------------------------------------------
	{
		src = gh 'nvim-treesitter/nvim-treesitter',
		version = 'main'
	},
	gh 'JoosepAlviste/nvim-ts-context-commentstring',
	gh 'lukas-reineke/indent-blankline.nvim',  -- Indentation guides


	---[ TEST RUNNER ]---------------------------------------------------------
	gh 'nvim-neotest/nvim-nio',          -- Dependency of Neotest
	gh 'nvim-neotest/neotest',           -- Test running frontend
	gh 'nvim-neotest/neotest-vim-test',  -- Adapter for vim-test
	gh 'nvim-neotest/neotest-plenary',   -- Adapter for plenary
	gh 'nvim-neotest/neotest-python',    -- Adapter for Pytest
	gh 'jfpedroza/neotest-elixir',       -- Adapter for Elixir


	---[ LANGUAGE-SPECIFIC ]---------------------------------------------------------
	gh 'adolenc/cl-neovim',           -- Common Lisp
	gh 'monkoose/parsley',            -- Dependency of nvlime
	gh 'monkoose/nvlime',             -- Live Common Lisp evaluation
	gh 'elixir-editors/vim-elixir',   -- Elixir
	gh 'bakpakin/fennel.vim',         -- Fennel
	gh 'habamax/vim-godot',           -- GDScript (Godot)
	gh 'jparise/vim-graphql',         -- GraphQL
	gh 'janet-lang/janet.vim',        -- Janet
	gh 'udalov/kotlin-vim',           -- Kotlin
	gh 'igankevich/mesonic',          -- Meson
	gh 'zah/nim.vim',                 -- Nim
	gh 'peterhoeg/vim-qml',           -- QML
	gh 'wlangstroth/vim-racket',      -- Racket
	gh 'cespare/vim-toml',            -- TOML
	gh 'arrufat/vala.vim',            -- Vala
}
