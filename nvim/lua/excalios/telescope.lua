require('telescope').load_extension('gh')
require('telescope').load_extension('coc')
require('telescope').load_extension('fzf')

local mappings = {

}

mappings.ff = function()
    require('telescope.builtin').find_files({
        hidden = false
    })
end

mappings.fg = function()
    require('telescope.builtin').git_files()
end

mappings.fb = function()
    require('telescope.builtin').buffers()
end

mappings.tgf = function()
    require('telescope.builtin').file_browser({
            hidden = false
    })
end

mappings.tlg = function()
    require('telescope.builtin').live_grep()
end

return mappings
