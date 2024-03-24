return {
  {
    'puremourning/vimspector',
    keys = {
      { "<leader>ds", "<cmd>VimspectorContinue<CR>", desc = "Vimspector Continue" },
      { "<leader>db", "<cmd>VimspectorBalloonEval<CR>", desc = "Vimspector Balloon Eval" },
    }
  },

  {
    'szw/vim-maximizer',
    keys = {
      { "<A-m>", "<cmd>MaximizerToggle!<CR>", desc = "Maximizer Toggle" },
    }
  },

  {
    'vim-test/vim-test',
    keys = {
      {"t<C-f>", "<cmd>TestFile<CR>", desc = "Test File"},
      {"t<C-n>", "<cmd>TestNearest<CR>", desc = "Test Nearest"},
      {"t<C-s>", "<cmd>TestSuite<CR>", desc = "Test Suite"},
      {"t<C-l>", "<cmd>TestLast<CR>", desc = "Test Last"},
    },
    config = function()
      vim.g["test#strategy"] = "neovim"
      vim.g["test#preserve_screen"] = 1
      vim.g["test#neovim#term_position"] = "vert"
      vim.g["test#echo_command"] = 0

      vim.g["test#php#phpunit#executable"] = "php artisan test"
      vim.g["test#go#gotest#options"] = "-v"
    end
  },
}

