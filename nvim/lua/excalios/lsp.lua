require('nvim-autopairs').setup{}

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require('cmp')
local luasnip = require("luasnip")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

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

--local tabnine = require("cmp_tabnine.config")
--tabnine:setup({
	--max_lines = 1000,
	--max_num_results = 20,
	--sort = true,
	--run_on_every_keystroke = true,
	--snippet_placeholder = "..",
	--show_prediction_strength = true,
--})

cmp.setup({
		--completion = {
			--completeopt = 'menuone,noinsert,noselect'
		--},
		preselect = cmp.PreselectMode.None,
    snippet = {
        expand = function(args)
						 require('luasnip').lsp_expand(args.body)
            --vim.fn["UltiSnips#Anon"](args.body)
        end
    },
    mapping = {
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
					-- they way you will only jump inside the snippet region
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
        --{ name = 'ultisnips' },
        { name = 'buffer' },
    },
		--formatting = {
			--format = lspkind.cmp_format({
				--mode = 'symbol_text',
				--maxwidth = 50,
				--ellipsis_char = '...',
		--},
		formatting = {
			format = function(entry, vim_item)
				-- if you have lspkind installed, you can use it like
				-- in the following line:
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
    --formatting = {
			--format = function(entry, vim_item)
							--vim_item.kind = lspkind.presets.default[vim_item.kind] .. ' ' .. vim_item.kind
							--local menu = source_mapping[entry.source.name]
							--if entry.source.name == 'cmp_tabnine' then
								--if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
									--menu = entry.completion_item.data.detail .. ' ' .. menu
								--end
								--vim_item.kind = ''
							--end
							--vim_item.menu = menu
							--return vim_item
			--end
		--},
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
require'lspconfig'.rust_analyzer.setup(config({
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
require'lspconfig'.html.setup(config())
require'lspconfig'.emmet_ls.setup(config())
require'lspconfig'.cssls.setup(config())
--require'lspconfig'.cssmodules_ls.setup(config())

require'lspconfig'.intelephense.setup(config())

require'lspconfig'.gdscript.setup(config())

require'lspconfig'.dartls.setup(config())
require'lspconfig'.kotlin_language_server.setup(config())

require'lspconfig'.tsserver.setup(config())
require'lspconfig'.dockerls.setup(config())
require'lspconfig'.eslint.setup(config())
require'lspconfig'.yamlls.setup(config())
require'lspconfig'.jsonls.setup(config())

--require'lspconfig'.clangd.setup(config())
require'lspconfig'.jedi_language_server.setup(config())
require'lspconfig'.gopls.setup(config({
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

require'lspconfig'.lua_ls.setup(config({
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
