return {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "html",
    "css",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact"
  },
  -- Restricting root markers ensures Tailwind LS only starts in actual Tailwind projects
  root_markers = { "package.json", "vite.config.ts" },
}
