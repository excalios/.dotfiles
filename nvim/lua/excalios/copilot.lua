vim.g.copilot_assume_mapped = true
vim.keymap.set('i', '<C-X>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true
