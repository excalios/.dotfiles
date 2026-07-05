-- lua/excalios/plugins/lsp/lspconfig.lua
return {
  'hrsh7th/cmp-nvim-lsp', -- needed only for capabilities
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "j-hui/fidget.nvim", opts = {} },
  },
  config = function()
    vim.lsp.config('*', {
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })

    vim.lsp.enable({
      'vtsls',
      'tailwindcss',
      'emmet_ls',
      'yamlls',
      'dockerls',
      'eslint',
      'jsonls',
      'pyright',
      'gopls',
      'lua_ls',
      'expert', -- Elixir
    })
  end
}
