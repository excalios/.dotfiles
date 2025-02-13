return {
  {
    'preservim/nerdcommenter',
    keys = {
      { "<C-_>", "<Plug>NERDCommenterToggle", desc = "Comment", mode={"n", "x"}},
    }
  },

  { 'tpope/vim-surround' },

  {
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("textcase").setup({})
      require("telescope").load_extension("textcase")
    end,
    keys = {
      "ga", -- Default invocation prefix
      { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Text Case Telescope" },
    },
  },

  {
    'theprimeagen/refactoring.nvim',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      print_var_statements = {
          javascript = {
              'console.debug("%s ", %s);'
          },
          typescript = {
              'console.debug("%s ", %s);'
          },
          gdscript = {
              'print_debug("%s ", %s)'
          }
      },
    },
    keys = {
      {"<leader>rp", "<cmd>lua require('refactoring').debug.printf({below = false})<CR>", desc = "Refactor Print"},
      {"<leader>rv", "<cmd>lua require('refactoring').debug.print_var()<CR>", desc = "Refactor Print Var", mode={"n", "x"}},
      {"<leader>rc", "<cmd>lua require('refactoring').debug.cleanup({})<CR>", desc = "Refactor Cleanup"},
      {"<leader>rr", ":Refactor ", desc = "Refactor Cleanup", mode={"n", "x"}},
    },
    config = function()
      require("refactoring").setup()
    end,
  },

  {
    'ggandor/leap.nvim',
    dependencies = {
      { 'tpope/vim-repeat' },
    },
    config = function()
      require('leap').add_default_mappings()
    end
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config  = function()
      local harpoon = require("harpoon")
      harpoon:setup({
        settings = {
          save_on_toggle = true,
        }
      })

      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
      vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

      vim.keymap.set("n", "<A-h>", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<A-t>", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<A-n>", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<A-s>", function() harpoon:list():select(4) end)
    end
  },

  {
    'mbbill/undotree',
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Undo Tree" },
    }
  }
}
