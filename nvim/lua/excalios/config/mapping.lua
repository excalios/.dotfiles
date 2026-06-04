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
-- quickfix list delete keymap
function Remove_qf_item()
  local curqfidx = vim.fn.line('.')
  local qfall = vim.fn.getqflist()

  -- Return if there are no items to remove
  if #qfall == 0 then return end

  -- Remove the item from the quickfix list
  table.remove(qfall, curqfidx)
  vim.fn.setqflist(qfall, 'r')

  -- Reopen quickfix window to refresh the list
  vim.cmd('copen')

  -- If not at the end of the list, stay at the same index, otherwise, go one up.
  local new_idx = curqfidx < #qfall and curqfidx or math.max(curqfidx - 1, 1)

  -- Set the cursor position directly in the quickfix window
  local winid = vim.fn.win_getid() -- Get the window ID of the quickfix window
  vim.api.nvim_win_set_cursor(winid, { new_idx, 0 })
end

vim.cmd("command! RemoveQFItem lua Remove_qf_item()")
vim.api.nvim_command("autocmd FileType qf nnoremap <buffer> dd :RemoveQFItem<cr>")

-- Terminal
keymap.set("t", "<C-o>", "<C-\\><C-n>", { noremap = true, silent = true })

-- Global Clipboard

-- Visual Mode: Select text, then press 'gy' to copy to Mac Clipboard
vim.keymap.set('v', 'gy', '"+y', { desc = 'Copy to system clipboard' })

-- Normal Mode: Press 'gy' + motion (e.g., 'gyip', 'gyw')
vim.keymap.set('n', 'gy', '"+y', { desc = 'Copy to system clipboard' })

-- Normal Mode: Press 'gY' to copy the whole line to Mac Clipboard
vim.keymap.set('n', 'gY', '"+Y', { desc = 'Copy line to system clipboard' })

-- Map "Leader + Tab" to switch to the previous buffer
vim.keymap.set("n", "<leader><tab>", "<C-^>", { desc = "Switch to last buffer" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { noremap = true, buffer = args.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
  end,
})
