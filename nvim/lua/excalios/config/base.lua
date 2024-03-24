-- Base.lua
-- For more info on general settings run `:h vim.opt`
--    example logging: `print(vim.inspect(vim.opt.wildignore:get()))`]]

-- viml/lua scope reference:
--    general settings: `vim.o` -- Things you'd normally set with `set`
--    window:           `viw.wo`
--    buffer:           `vim.bo`
--    global:           `vim.g` -- Things you would set with `let`

local set = vim.opt

-- Disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Allow backspacing over everything in insert mode
set.backspace = {"indent", "eol", "start"}
set.ruler = true
set.showcmd = true
set.wildmenu = true
set.cursorline = true
set.termguicolors = true
-- Makes vim redraw when running macros
set.lazyredraw = false

-- read/write a .viminfo file, don't store more than 50 lines of registers
set.history = 50

-- Show a few lines of context around the cursor
set.scrolloff = 5

set.ignorecase = true
set.smartcase = true

set.incsearch = true
set.hlsearch = false
set.inccommand = "split"

vim.wo.number = true
vim.wo.relativenumber = true

set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.smartindent = true
set.autoindent = true
set.expandtab = true

set.splitright = true

set.colorcolumn = "80"

set.updatetime = 100
set.completeopt = {"menuone", "noselect"}

set.list = true

set.wrap = false
set.breakindent = true
set.title = true

vim.scriptencoding = "utf-8"
set.encoding = "utf-8"
set.fileencoding = "utf-8"

-- Prettier
vim.g["prettier#autoformat"] = 1
vim.g["prettier#autoformat_require_pragma"] = 0

-- Debugger
vim.g["vimspector_enable_mappings"] = "HUMAN"

-- Maximizer
vim.g["maximizer_set_default_mapping"] = 0

vim.g["python3_host_prog"] = "/opt/homebrew/bin/python3.11"
