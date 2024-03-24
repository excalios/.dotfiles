return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
      { "nvim-telescope/telescope-file-browser.nvim" },
      { 'nvim-tree/nvim-web-devicons' },
    },
    config = function()
      local telescope = require('telescope')
      telescope.load_extension('fzf')
      telescope.load_extension('file_browser')
      telescope.load_extension('harpoon')
      telescope.load_extension('git_worktree')
      telescope.load_extension('refactoring')
      telescope.load_extension('textcase')
    end,
    keys = {
      { "<leader>rr", function() require('telescope').extensions.refactoring.refactors() end },
      { '<leader>ff', function() require('telescope.builtin').find_files() end },
      { '<leader>fh', function() require('telescope.builtin').find_files({ hidden = true, no_ignore = true }) end },
      { '<leader>fb', function() require('telescope.builtin').buffers() end },
      { '<leader>tgf', function() require('telescope').extensions.file_browser.file_browser({ path="%:p:h" }) end },
      { '<leader>tlg', function() require('telescope.builtin').live_grep() end },
      { 'ga.', '<cmd>TextCaseOpenTelescope<CR>' },
    }
  }
}
