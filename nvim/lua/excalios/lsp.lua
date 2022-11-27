require('nvim-autopairs').setup{}

local cmp = require'cmp'
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

cmp.setup({
    sources={
        { name = 'orgmode' }
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

-- Auto pair
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

cmp.setup({
		completion = {
			completeopt = 'menuone,noinsert,noselect'
		},
    snippet = {
        expand = function(args)
						 require('luasnip').lsp_expand(args.body)
            --vim.fn["UltiSnips#Anon"](args.body)
        end
    },
    mapping = {
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
     },
    sources = {
        { name = "cmp_tabnine" },
        { name = 'nvim_lsp' },
				 { name = 'luasnip' },
        --{ name = 'ultisnips' },
        { name = 'buffer' },
    },
    formatting = {
			format = function(entry, vim_item)
							vim_item.kind = lspkind.presets.default[vim_item.kind] .. ' ' .. vim_item.kind
							local menu = source_mapping[entry.source.name]
							if entry.source.name == 'cmp_tabnine' then
								if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
									menu = entry.completion_item.data.detail .. ' ' .. menu
								end
								vim_item.kind = ''
							end
							vim_item.menu = menu
							return vim_item
			end
		},
})

local tabnine = require("cmp_tabnine.config")
tabnine:setup({
	max_lines = 1000,
	max_num_results = 20,
	sort = true,
	run_on_every_keystroke = true,
	snippet_placeholder = "..",
})

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

require'lspconfig'.jdtls.setup(config())
require'lspconfig'.rust_analyzer.setup(config())

-- Web Language Server
require'lspconfig'.html.setup(config())
require'lspconfig'.emmet_ls.setup(config())
--require'lspconfig'.cssls.setup(config())
--require'lspconfig'.cssmodules_ls.setup(config())

--require'lspconfig'.intelephense.setup(config())

--require'lspconfig'.gdscript.setup(config())

require'lspconfig'.dartls.setup(config())

require'lspconfig'.tsserver.setup(config())
require'lspconfig'.dockerls.setup(config())
require'lspconfig'.eslint.setup(config())
require'lspconfig'.yamlls.setup(config())
require'lspconfig'.jsonls.setup(config())

--require'lspconfig'.clangd.setup(config())
require'lspconfig'.jedi_language_server.setup(config())
require'lspconfig'.gopls.setup(config({
    cmd = {"gopls", "serve"},
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
}))

require'lspconfig'.sumneko_lua.setup(config({
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

-- Show Diagnosticts
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
