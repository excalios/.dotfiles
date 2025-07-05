return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },

  version = '1.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {

    keymap = { preset = 'default' },

    appearance = {
      nerd_font_variant = 'mono'
    },

    completion = {
      documentation = { auto_show = true },
      accept = { auto_brackets = { enabled = true }, },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },

    signature = { enabled = true }
  },
  opts_extend = { "sources.default" }
}
