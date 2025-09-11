local lspconfig = function()
  local cmp = require('cmp')
  local luasnip = require("luasnip")

  local lspkind = require('lspkind')
  lspkind.mode = 'text'

  local cmp_select = { behavior = cmp.SelectBehavior.Select }

  cmp.setup({
      preselect = cmp.PreselectMode.None,
      snippet = {
          expand = function(args)
               luasnip.lsp_expand(args.body)
          end
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = {
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
       },
      sources = cmp.config.sources(
        {
          { name = 'nvim_lsp_signature_help' },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        },
        {
          { name = 'buffer' },
        },
        {
          { name = 'cmp_zotcite' },
        }
      ),
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol',
          maxwidth = {
            menu = 50,
            abbr = 50,
          },
          ellipsis_char = '...',
          show_labelDetails = true,
          before = function (entry, vim_item)
            return vim_item
          end
        })
      }
  })
end

return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'onsails/lspkind-nvim' },
      { 'prabirshrestha/async.vim' },
      { 'L3MON4D3/LuaSnip' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'jalvesaq/cmp-zotcite' }
    },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
    config = lspconfig,
  },
}
