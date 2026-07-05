-- nvim/lsp/ty.lua
return {
  cmd = { "/Users/v01d/.local/bin/ty", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", ".git" },
  single_file_support = true,
}
