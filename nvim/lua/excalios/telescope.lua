require('telescope').load_extension('gh')
--require('telescope').load_extension('coc')
require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')
require('telescope').load_extension('harpoon')
require('telescope').load_extension('git_worktree')
require('telescope').load_extension('media_files')
-- load refactoring Telescope extension
require("telescope").load_extension("refactoring")

vim.keymap.set(
    {"n", "x"},
    "<leader>rr",
    function() require('telescope').extensions.refactoring.refactors() end
)

local mappings = {

}

mappings.ff = function()
    require('telescope.builtin').find_files()
end

mappings.fm = function()
    require('telescope').extensions.media_files.media_files()
end

mappings.find_hidden = function()
    require('telescope.builtin').find_files({
        hidden = true,
        no_ignore = true
    })
end

mappings.fg = function()
    require('telescope.builtin').git_files()
end

mappings.fb = function()
    require('telescope.builtin').buffers()
end

mappings.tgf = function()
    require 'telescope'.extensions.file_browser.file_browser({
        path="%:p:h"
    })
end


mappings.tlg = function()
    require('telescope.builtin').live_grep()
end

return mappings
