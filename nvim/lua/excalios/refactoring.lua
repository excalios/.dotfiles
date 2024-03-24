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
vim.keymap.set(
    "n",
    "<leader>rp",
    function() require('refactoring').debug.printf({below = false}) end
)

-- Print var
vim.keymap.set({"x", "n"}, "<leader>rv", function() require('refactoring').debug.print_var() end)

-- Cleanup function: this remap should be made in normal mode
vim.keymap.set("n", "<leader>rc", function() require('refactoring').debug.cleanup({}) end)
