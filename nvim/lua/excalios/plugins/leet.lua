return {
  {
      "kawre/leetcode.nvim",
      build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
      dependencies = {
          "nvim-telescope/telescope.nvim",
          -- "ibhagwan/fzf-lua",
          "nvim-lua/plenary.nvim",
          "MunifTanjim/nui.nvim",
      },
      opts = {
          storage = {
            home = "~/dev/leetcode",
            cache = "~/dev/leetcode",
          },
          picker = { provider = 'telescope' },
          lang = "python3",
          hooks = {
            ---@type fun()[]
            ["enter"] = {
            },

            ---@type fun(question: lc.ui.Question)[]
            ["question_enter"] = {
             function()
               vim.b.copilot_enabled = false
             end
            },

            ---@type fun()[]
            ["leave"] = {},
          },
      },
  }
}
