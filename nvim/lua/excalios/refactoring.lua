require('refactoring').setup({
    print_var_statements = {
        javascript = {
            'console.debug("%s ", %s);'
        },
        typescript = {
            'console.debug("%s ", %s);'
        },
        gdscript = {
            'print_debug("%s ", %s)'
        }
    },
})

-- You can also use below = true here to to change the position of the printf
-- statement (or set two remaps for either one). This remap must be made in normal mode.
vim.api.nvim_set_keymap(
    "n",
    "<leader>rp",
    ":lua require('refactoring').debug.printf({below = false})<CR>",
    { noremap = true }
)

-- Print var

-- Remap in normal mode and passing { normal = true } will automatically find the variable under the cursor and print it
vim.api.nvim_set_keymap("n", "<leader>rv", ":lua require('refactoring').debug.print_var({ normal = true })<CR>", { noremap = true })
-- Remap in visual mode will print whatever is in the visual selection
vim.api.nvim_set_keymap("v", "<leader>rv", ":lua require('refactoring').debug.print_var({})<CR>", { noremap = true })

-- Cleanup function: this remap should be made in normal mode
vim.api.nvim_set_keymap("n", "<leader>rc", ":lua require('refactoring').debug.cleanup({})<CR>", { noremap = true })
