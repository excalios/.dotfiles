vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require('excalios.config.base')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "excalios.plugins" },
  { import = "excalios.plugins.lsp" }
})

require('excalios.config.mapping')
