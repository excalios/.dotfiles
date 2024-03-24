-- Maps.lua
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
local keymap = vim.keymap

-- Moving through buffers
keymap.set("n", "<C-h>", "<cmd>bprevious<CR>", { noremap = true, silent = true })
keymap.set("n", "<C-l>", "<cmd>bnext<CR>", { noremap = true, silent = true })

-- Quickfix list
keymap.set("n", "<C-k>", "<cmd>cp<CR>", { noremap = true, silent = true })
keymap.set("n", "<C-j>", "<cmd>cn<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>cq", "<cmd>ccl<CR>", { noremap = true, silent = true })

-- Terminal
keymap.set("t", "<C-o>", "<C-\\><C-n>", { noremap = true, silent = true })
