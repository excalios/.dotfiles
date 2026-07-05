return {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml" },

  single_file_support = true,

  settings = {
    python = {
      analysis = {
        -- Prevents it from crawling untyped node_modules or massive datasets
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,

        -- Crucial for performance on an 8GB machine
        diagnosticMode = "openFilesOnly",

        -- You can set this to "strict" if you want the pedantic checking back
        typeCheckingMode = "strict",
      }
    }
  }
}
