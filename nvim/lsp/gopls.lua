return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gosum", "gotmpl" },
  root_markers = { "go.mod", "go.sum", ".git" },
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
  init_options = {
    usePlaceholders = true,
  }
}
