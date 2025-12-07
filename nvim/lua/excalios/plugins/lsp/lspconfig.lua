return {
  'neovim/nvim-lspconfig',
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    {
      "j-hui/fidget.nvim",
      opts = {},
    },
    { 'prabirshrestha/async.vim' },
  },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    function CreateNoremap(type, opts)
      return function(lhs, rhs, bufnr)
            bufnr = bufnr or 0
        vim.api.nvim_buf_set_keymap(bufnr, type, lhs, rhs, opts)
      end
    end

    Nnoremap = CreateNoremap("n", { noremap = true })
    Inoremap = CreateNoremap("i", { noremap = true })


    local function config(_config)
      return vim.tbl_deep_extend("force", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = function()
          Nnoremap("gD", ":lua vim.lsp.buf.declaration()<CR>")
          Nnoremap("gd", ":lua vim.lsp.buf.definition()<CR>")
          Nnoremap("K", ":lua vim.lsp.buf.hover()<CR>")
          Nnoremap("gi", ":lua vim.lsp.buf.implementation()<CR>")
          Nnoremap("gr", ":lua vim.lsp.buf.references()<CR>")
          Nnoremap("<leader>vws", ":lua vim.lsp.buf.workspace_symbol()<CR>")
          Nnoremap("<space>e", ":lua vim.diagnostic.open_float()<CR>")
          Nnoremap("[d", ":lua vim.diagnostic.goto_next()<CR>")
          Nnoremap("]d", ":lua vim.diagnostic.goto_prev()<CR>")
          Nnoremap("<leader>ca", ":lua vim.lsp.buf.code_action()<CR>")
          Nnoremap("<leader>rn", ":lua vim.lsp.buf.rename()<CR>")
          Inoremap("<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
        end,
      }, _config or {})
    end

    vim.lsp.config('*', config())

    -- vim.lsp.config('ts_ls', config())
    vim.lsp.enable('ts_ls')


    -- vim.lsp.config('yamlls', config())
    vim.lsp.enable('yamlls')
    vim.lsp.enable({'dockerls', 'eslint', 'yamlls', 'jsonls'})

    -- vim.lsp.config('pyright', config())
    vim.lsp.enable('pyright')

    vim.lsp.config('gopls', config({
        cmd = {"gopls"},
        settings = {
          gopls = {
            experimentalPostfixCompletions = true,
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
          },
        },
        init_options = {
          usePlaceholders = true,
        }
    }))
    vim.lsp.enable('gopls')

    vim.lsp.config('lua_ls', config({
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    }))
    vim.lsp.enable('lua_ls')

    vim.lsp.config('elixirls', config({
      cmd = { "/Users/v01d/dev/elixir/lsp/language_server.sh" };
    }))
    vim.lsp.enable('elixirls')
  end
}
