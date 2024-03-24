return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      integrations = {
        gitsigns = true,
        harpoon = true,
        leap = true,
        indent_blankline = {
            enabled = true,
            scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
            colored_indent_levels = false,
        },
        cmp = true,
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
        treesitter = true,
        treesitter_context = true,
        telescope = {
          enabled = true,
        },
        lsp_trouble = true,
        gitgutter = true,
      }
    }
  },

  --{
    --"ellisonleao/gruvbox.nvim",
    --priority = 1000
  --},

  --{
  --"folke/tokyonight.nvim",
    --lazy = false,
    --priority = 1000,
  --}
}
