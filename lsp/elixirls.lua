-- https://github.com/elixir-lsp/elixir-ls

return {
	cmd = {'elixirls'},
    filetypes = {'elixir', 'eelixir', 'heex', 'surface'},
    -- This is flawed because there might exist a higher-priority mix.ex in the
    -- parent directory.
	root_markers = {'mix.exs'},
}
