local Worktree = require("git-worktree")
local harpoon_term = require("harpoon.term")

Worktree.on_tree_change(function(op, metadata)
    --print("Path is " .. metadata.path .. " file exists ", vim.fn.filereadable(metadata.path .. "/package-lock.json"), "Operations is", op)
    if op == Worktree.Operations.Switch then
        --if vim.fn.filereadable(metadata.path .. "/package-lock.json") == 1 then
            --if vim.fn.isdirectory(metadata.path .. "/node_modules") == 0 then
                --vim.fn.execute('vsplit')
                --harpoon_term.gotoTerminal(1)
                --harpoon_term.sendCommand(1, "npm ci --prefix " .. metadata.path .. " && exit \n")
                --vim.fn.execute('10000') -- go to the bottom of the buffer so it will auto-scroll
                ----vim.cmd(":!tmux neww -n \"Package Install\" -c " .. metadata.path .. " \"npm ci;sleep 3\"")
            --end
        --end
    else
        --if op == Worktree.Operations.Create then
            --if vim.fn.filereadable(vim.fn.getcwd() .. '/' .. metadata.path .. "/package-lock.json") then
                --vim.fn.execute('vsplit')
                --harpoon_term.gotoTerminal(1)
                --harpoon_term.sendCommand(1, "npm ci && exit \n")
                --vim.fn.execute('10000') -- go to the bottom of the buffer so it will auto-scroll
                ----vim.cmd(":!tmux neww -n \"Package Install\" -c " .. vim.fn.getcwd() .. '/' .. metadata.path .. " \"npm ci;sleep 10\"")
            --end
        --end
    end
end)
