return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
          require('nvim-treesitter.configs').setup {
            highlight = {
              enable = true,
            },
            indent = {
              enable = true,
            },
            incremental_selection = {
              enable = true,
            },
            ensure_installed = {
              "typescript",
              "go",
            }
          }
        end,
      }
    },
    opts = {}
  },

  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    },
    keys = {
      {"<leader>xx", "<cmd>TroubleToggle<cr>"},
    }
  },

    -- Specific Languages

  { 'jpalardy/vim-slime' },

  {
    "prettier/vim-prettier",
    build = "yarn workspaces focus",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact", "css", "less", "scss", "json", "graphql", "markdown", "vue", "yaml", "html" },
    config = function()
      vim.g["prettier#autoformat"] = 1
      vim.g["prettier#autoformat_require_pragma"] = 0
    end
  },

  -- Go
  {
    'fatih/vim-go',
    ft = { 'go' },
  },

  -- DBML
  {
    'jidn/vim-dbml',
    ft = { 'dbml' },
  },

  -- Dart/Flutter
  {
    'dart-lang/dart-vim-plugin',
    ft = { 'dart' },
  },
  {
    'thosakwe/vim-flutter',
    ft = { 'dart' },
  },
  {
    'udalov/kotlin-vim',
    ft = { 'kotlin' },
  },

  -- Laravel
  {
    'noahfrederick/vim-laravel',
    dependencies = {
      { 'tpope/vim-dispatch' },
      { 'tpope/vim-projectionist' },
      { 'noahfrederick/vim-composer' },
    },
    ft = { 'php' },
  },

  -- Godot
  {
    'habamax/vim-godot',
    ft = { 'gd', 'gdscript3' },
  },
}
