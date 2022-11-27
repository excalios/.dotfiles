require('telescope').load_extension('gh')
--require('telescope').load_extension('coc')
require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')
require('telescope').load_extension('harpoon')
require('telescope').load_extension('git_worktree')

local mappings = {

}

mappings.of = function()
    require('telescope.builtin').find_files({
            cwd = '~/Documents/orgs'
        })
end

mappings.ff = function()
    require('telescope.builtin').find_files()
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

mappings.ogf = function()
    require 'telescope'.extensions.file_browser.file_browser({
            cwd = '~/Documents/orgs'
        })
end

mappings.tlg = function()
    require('telescope.builtin').live_grep()
end

return mappings
