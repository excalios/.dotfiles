return {
  cmd = { "vtsls", "--stdio" },
  filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  root_markers = { "package.json", "tsconfig.json", ".git" },
  settings = {
    vtsls = {
      autoUseWorkspaceTsdk = true, -- uses project's own TS version
    },
    typescript = {
      updateImportsOnFileMove = { enabled = "always" },
      suggest = { completeFunctionCalls = true },
    },
    javascript = {
      updateImportsOnFileMove = { enabled = "always" },
    },
  }
}
