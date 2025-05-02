return {
  { 'ThePrimeagen/git-worktree.nvim', lazy = true, enabled = false },
  { 'sindrets/diffview.nvim' },
  {
    'tpope/vim-fugitive',
    keys = {
      { '<leader>gs', '<cmd>G<CR>', desc = 'Git Status' },
      { '<leader>gh', '<cmd>diffget //3<CR>', desc = 'Git Diff Get Head' },
      { '<leader>gu', '<cmd>diffget //2<CR>', desc = 'Git Diff Get Base' },
    }
  },
  {
    "rbong/vim-flog",
    lazy = true,
    cmd = { "Flog", "Flogsplit", "Floggit" },
    dependencies = {
      "tpope/vim-fugitive",
    },
  },
}
