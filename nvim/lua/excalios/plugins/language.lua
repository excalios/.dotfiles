return {
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.icons').setup()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup {
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "markdown" }, -- for the obsidian style %% comments
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
          "lua",
          "vim",
          "sql",
          "markdown",
          "markdown_inline"
        }
      }
    end,
    dependencies = { "OXY2DEV/markview.nvim" },
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
      },
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
      {"<leader>xx", "<cmd>Trouble diagnostics toggle<cr>"},
    }
  },

    -- Specific Languages

  {
    'jpalardy/vim-slime',
    config = function()
      vim.g["slime_target"] = "tmux"
      vim.g["slime_bracketed_paste"] = 1
    end,
  },

  {
    "prettier/vim-prettier",
    build = "yarn workspaces focus",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact", "css", "less", "scss", "json", "graphql", "vue", "yaml", "html" },
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
    dependencies = {
      { 'tpope/vim-dispatch' },
    },
    ft = { 'gd', 'gdscript3', 'gdscript' },
    config = function()
      vim.cmd([[
        augroup gdscript
          autocmd!
          autocmd FileType gdscript setlocal tabstop=4 shiftwidth=4
        augroup END
      ]])
      vim.g["godot_executable"] = "/opt/homebrew/bin/Godot"
    end
  },
}
