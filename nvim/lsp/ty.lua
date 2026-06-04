-- nvim/lsp/ty.lua
return {
  cmd = { "ty", "server" },
  filetypes = { "python" },

  -- In Neovim 0.12, root_dir takes the buffer name (a string)
  root_dir = function(filename)
    -- 1. Try to find a project marker
    local root = vim.fs.root(filename, { "pyproject.toml", ".git" })

    -- 2. If it's nil, force the directory of the file itself, NOT getcwd().
    -- Using the file's own directory ensures ty always has a valid path to parse,
    -- even if you launched Neovim from a weird monorepo root.
    if not root then
      root = vim.fs.dirname(filename)
    end

    return root
  end,

  -- Force single file fallback
  single_file_support = true,
}
