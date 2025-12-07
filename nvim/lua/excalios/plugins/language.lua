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
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'go',
          'gomod',
          'gosum',
          'python',
          'lua',
          'json',
          'markdown',
          'javascript',
          'typescript',
          'javascriptreact',
          'typescriptreact',
          'html',
          'css',
          'less',
          'scss',
          'yaml',
          'elixir',
        },
        callback = function()
          vim.treesitter.start()
          vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          -- vim.wo.foldmethod = 'expr'
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      require'nvim-treesitter'.setup {
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
      {"[t", function() require("trouble").previous({skip_groups = true, jump = true}) end},
      {"]t", function() require("trouble").next({skip_groups = true, jump = true}) end},
    }
  },

  {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
      require("conform").setup({
        format_on_save = {
          timeout_ms = 5000,
                  lsp_format = "fallback",
        },
        formatters_by_ft = {
          c = { "clang-format" },
          cpp = { "clang-format" },
          lua = { "stylua" },
          go = { "gofmt" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          elixir = { "mix" },
        },
        formatters = {
          ["clang-format"] = {
            prepend_args = { "-style=file", "-fallback-style=LLVM" },
          },
        },
      })

      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   pattern = "*",
      --   callback = function(args)
      --     require("conform").format({ bufnr = args.buf })
      --   end,
      -- })

      vim.keymap.set("n", "<leader>f", function()
        require("conform").format({ bufnr = 0 })
      end)
    end,
  },

    -- Specific Languages

  {
    'jpalardy/vim-slime',
    config = function()
      vim.g["slime_target"] = "wezterm"
      vim.g["slime_default_config"] = {pane_direction= "right"}
      vim.g["slime_bracketed_paste"] = 1
    end,
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
