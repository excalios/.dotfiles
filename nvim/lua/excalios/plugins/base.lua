return {
  -- {
  --   'github/copilot.vim',
  --   config = function()
  --     vim.g.copilot_assume_mapped = true
  --     vim.keymap.set('i', '<C-X>', 'copilot#Accept("\\<CR>")', {
  --       expr = true,
  --       replace_keycodes = false
  --     })
  --     vim.g.copilot_no_tab_map = true
  --   end,
  --   enabled = true
  -- },

  { 'wakatime/vim-wakatime' },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        config = function()
          vim.notify = require("notify")
        end
      },
    },
    opts = {},
  },
}
