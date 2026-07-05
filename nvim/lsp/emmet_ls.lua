return {
  cmd = { "emmet-language-server", "--stdio" },
  filetypes = {
    "html",
    "typescriptreact",
    "javascriptreact",
    "css",
    "sass",
    "scss",
    "less"
  },
  root_markers = { "package.json", ".git" },
  init_options = {
    html = {
      options = {
        -- Translates standard HTML 'class' to React's 'className'
        ["markup.attributes"] = {
          class = "className",
        },
      },
    },
  },
}
