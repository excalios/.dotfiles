return {
  {
    'preservim/nerdcommenter',
    keys = {
      { "<C-_>", "<Plug>NERDCommenterToggle", desc = "Comment" },
    }
  },

  { 'tpope/vim-surround' },

  {
    'johmsalas/text-case.nvim',
    config = function()
      vim.api.nvim_set_keymap('n', 'ga.', "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
      vim.api.nvim_set_keymap('v', 'ga.', "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
    end
  },

  {
    'theprimeagen/refactoring.nvim',
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
      {"<leader>rv", "<cmd>lua require('refactoring').debug.print_var()<CR>", desc = "Refactor Print Var"},
      {"<leader>rc", "<cmd>lua require('refactoring').debug.cleanup({})<CR>", desc = "Refactor Cleanup"},
    }
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
      harpoon:setup()

      vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
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
