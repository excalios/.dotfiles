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
      'yamlls',
      'dockerls',
      'eslint',
      'jsonls',
      'ty',
      'gopls',
      'lua_ls',
      'expert', -- Elixir
    })
  end
}
