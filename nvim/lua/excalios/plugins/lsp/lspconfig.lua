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
    local lsp = require('lspconfig')
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

    lsp.jdtls.setup(config())
    lsp.rust_analyzer.setup(config({
      settings = {
        ["rust-analyzer"] = {
          imports = {
            granularity = {
              group = "module",
            },
            prefix = "self",
          },
          cargo = {
            buildScripts = {
              enable = true,
            },
          },
          procMacro = {
            enable = true
          },
        }
      }
    }))

    -- Web Language Server
    lsp.html.setup(config())
    lsp.emmet_ls.setup(config())
    lsp.cssls.setup(config())
    --lsp.cssmodules_ls.setup(config())

    lsp.intelephense.setup(config())

    lsp.gdscript.setup(config())

    lsp.dartls.setup(config())
    lsp.kotlin_language_server.setup(config())

    -- vim.lsp.config("ts_go_ls", {
    --     cmd = { vim.loop.os_homedir() .. "/dev/typescript-go/built/local/tsgo", "lsp", "-stdio" },
    --     filetypes = {
    --         "javascript",
    --         "javascriptreact",
    --         "javascript.jsx",
    --         "typescript",
    --         "typescriptreact",
    --         "typescript.tsx",
    --     },
    --     root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
    -- })
    -- vim.lsp.enable("ts_go_ls")
    vim.lsp.config('ts_ls', config())
    vim.lsp.enable('ts_ls')
    -- lsp.ts_ls.setup(config())
    lsp.tailwindcss.setup(config())
    lsp.dockerls.setup(config())
    lsp.eslint.setup(config())
    lsp.yamlls.setup(config())
    lsp.jsonls.setup(config())

    --lsp.clangd.setup(config())
    vim.lsp.config('pyright', config())
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

    lsp.lua_ls.setup(config({
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
  end
}
