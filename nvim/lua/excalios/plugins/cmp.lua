local lspconfig = function()
  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local cmp = require('cmp')
  local luasnip = require("luasnip")

  cmp.setup({
      sources={
        { name = "nvim_lsp" },
        { name = 'nvim_lsp_signature_help' },
      }
  })

  local lspkind = require('lspkind')
  lspkind.mode = 'text'

  local source_mapping = {
    buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    nvim_lua = "[Lua]",
    cmp_tabnine = "[TN]",
    path = "[Path]",
  }

  local signs = {
    Error = "",
    Warn = "",
    Hint = "",
    Info = "",
  }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- Auto pair
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

  local compare = require('cmp.config.compare')

  cmp.setup({
      preselect = cmp.PreselectMode.None,
      snippet = {
          expand = function(args)
               require('luasnip').lsp_expand(args.body)
          end
      },
      mapping = {
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping({
             i = function(fallback)
               if cmp.visible() and cmp.get_active_entry() then
                 cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
               else
                 fallback()
               end
             end,
             s = cmp.mapping.confirm({ select = true }),
             c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
          }),
       },
    sorting = {
      priority_weight = 2,
      comparators = {
        require('cmp_tabnine.compare'),
        compare.offset,
        compare.exact,
        compare.score,
        compare.recently_used,
        compare.kind,
        compare.sort_text,
        compare.length,
        compare.order,
      },
    },
      sources = {
          { name = 'nvim_lsp_signature_help' },
          { name = "cmp_tabnine" },
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'buffer' },
      },
      formatting = {
        format = function(entry, vim_item)
          vim_item.kind = lspkind.symbolic(vim_item.kind, {mode = "symbol_text"})
          vim_item.menu = source_mapping[entry.source.name]
          if entry.source.name == "cmp_tabnine" then
            local detail = (entry.completion_item.data or {}).detail
            vim_item.kind = " TabNine"
            if detail and detail:find('.*%%.*') then
              vim_item.kind = vim_item.kind .. ' 1 ' .. detail
            end
            if (entry.completion_item.data or {}).multiline then
              vim_item.kind = vim_item.kind .. ' ' .. '[ML]'
            end
          end
          local maxwidth = 80
          vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
          return vim_item
        end,
      },
  })
end

return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      {
       'tzachar/cmp-tabnine',
       build = './install.sh',
      },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'onsails/lspkind-nvim' },
      { 'prabirshrestha/async.vim' },
      { 'L3MON4D3/LuaSnip' },
      { 'saadparwaiz1/cmp_luasnip' },
      {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
      }
    },
    config = lspconfig,
  },
}
