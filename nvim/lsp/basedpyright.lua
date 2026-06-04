return {
  cmd = { "basedpyright-langserver", "--stdio", "--max-old-space-size=4096" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml" },
  settings = {
    basedpyright = {
      analysis = {
        include = { "app" },
        autoSearchPaths = false,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
        -- typeCheckingMode = "all",
      }
    }
  }
}
