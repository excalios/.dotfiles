local configGoTest = { -- Specify configuration
  runner = "gotestsum",
  go_test_args = { "-v", "-race", "-count=1", "-p=1" },
}

-- NOTE: Might change to neotest, vim-dap
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

  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",

      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-vim-test",
      { "fredrikaverpil/neotest-golang", version = "*" },
    },
    config = function()
      require("neotest").setup({
        consumers = {
          timber = require("timber.watcher.sources.neotest").consumer,
        },
        adapters = {
          require("neotest-golang")(configGoTest), -- Registration
        },
      })
    end,
    keys = {
      { "<leader>ta", function() require("neotest").run.attach() end, desc = "[t]est [a]ttach" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "[t]est run [f]ile" },
      { "<leader>tA", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "[t]est [A]ll files" },
      { "<leader>tS", function() require("neotest").run.run({ suite = true }) end, desc = "[t]est [S]uite" },
      { "<leader>tn", function() require("neotest").run.run() end, desc = "[t]est [n]earest" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "[t]est [l]ast" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "[t]est [s]ummary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "[t]est [o]utput" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "[t]est [O]utput panel" },
      { "<leader>tt", function() require("neotest").run.stop() end, desc = "[t]est [t]erminate" },
    },
  }
}

