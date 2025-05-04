return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
      require("catppuccin").setup({
        transparent_background = true, -- disables setting the background color.
        flavour = "macchiato", -- latte, frappe, macchiato, mocha
        integrations = {
          gitsigns = true,
          harpoon = true,
          leap = true,
          indent_blankline = {
              enabled = true,
              scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
              colored_indent_levels = false,
          },
          neotest = true,
          cmp = true,
          copilot_vim = true,
          native_lsp = {
              enabled = true,
              virtual_text = {
                  errors = { "italic" },
                  hints = { "italic" },
                  warnings = { "italic" },
                  information = { "italic" },
              },
              underlines = {
                  errors = { "underline" },
                  hints = { "underline" },
                  warnings = { "underline" },
                  information = { "underline" },
              },
              inlay_hints = {
                  background = true,
              },
          },
          nvim_surround = true,
          treesitter = true,
          treesitter_context = true,
          telescope = {
            enabled = true,
          },
          lsp_trouble = true,
          gitgutter = true,
          markdown = true,
        }
      })
      vim.cmd.colorscheme "catppuccin"
    end,
    enabled = true,
  },
}
