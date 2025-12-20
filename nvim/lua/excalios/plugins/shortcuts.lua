return {
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },

  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },

  {
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("textcase").setup({})
      require("telescope").load_extension("textcase")
    end,
    keys = {
      "ga", -- Default invocation prefix
      { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Text Case Telescope" },
    },
  },

  {
    'theprimeagen/refactoring.nvim',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
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
    },
    keys = {
      { "<leader>rp", "<cmd>lua require('refactoring').debug.printf({below = false})<CR>", desc = "Refactor Print" },
      { "<leader>rv", "<cmd>lua require('refactoring').debug.print_var()<CR>",             desc = "Refactor Print Var", mode = { "n", "x" } },
      { "<leader>rc", "<cmd>lua require('refactoring').debug.cleanup({})<CR>",             desc = "Refactor Cleanup" },
      { "<leader>rr", ":Refactor ",                                                        desc = "Refactor Cleanup",   mode = { "n", "x" } },
    },
    config = function()
      require("refactoring").setup({})
    end,
  },

  {
    "Goose97/timber.nvim",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    keys = {
      { "gls",  "<cmd>lua require('timber.actions').insert_log({ templates = { before = 'default', after = 'default' }, position = 'surround' })<CR>",      desc = "Insert Log Statement" },
      { "glc",  "<cmd>lua require('timber.actions').clear_log_statements({ global = false })<CR>",                                                          desc = "Clear Log Statements" },
      { "glC",  "<cmd>lua require('timber.actions').clear_log_statements({ global = true })<CR>",                                                           desc = "Clear Log Statements (Global)" },
      { "glf",  "<cmd>lua require('timber.actions').search_log_statements()<CR>",                                                                           desc = "Search Log Statements" },
      { "glt",  "<cmd>lua require('timber.actions').insert_log({ templates = { before = 'time_start', after = 'time_end' }, position = 'surround', })<CR>", desc = "Calculate Time and log" },
      { "glOf", "<cmd>lua require('timber.buffers').open_float()<CR>",                                                                                      desc = "Open log result float window" },
      { "glOs", "<cmd>lua require('timber.summary').open({ focus = true })<CR>",                                                                            desc = "Open log result summary" },
    },
    config = function()
      local opts = {
        log_templates = {
          time_start = {
            python = {
              [[start_time = time.time()]],
              -- [[print(f"%log_marker %filename %line_number %watcher_marker_start start_time = {start_time} %watcher_marker_end")]],
              auto_import = "import time",
            }
          },
          time_end = {
            python = [[print("%filename %line_number Time taken to run:", time.time() - start_time)]],
          },
          default = {
            python = [[print(f"%watcher_marker_start {%log_target=} %watcher_marker_end")]],
            go = [[log.Printf("%watcher_marker_start %log_target: %v %watcher_marker_end\n", %log_target)]],
          },
          plain = {
            python = [[print(f"%log_marker %filename %line_number")]],
            go = [[log.Printf("%log_marker %filename %line_number")]],
            typescript = [[console.log("%log_marker %filename %line_number")]],
          },
        },
        batch_log_templates = {
          default = {
            python = [[print(f"%log_marker %repeat<{%log_target=}><, >")]],
            go = [[log.Printf("%log_marker %repeat<%log_target: %v><, >\n", %repeat<%log_target><, >)]],
          },
        },
        log_marker = "🪵", -- Or any other string, e.g: MY_LOG
        log_watcher = {
          enabled = true,
          -- A table of source id and source configuration
          sources = {
            log_file = {
              type = "filesystem",
              name = "Log file",
              path = "/tmp/debug.log",
            },
            neotest = {
              -- Test runner
              type = "neotest",
              name = "Neotest",
            },
          },
        }
      }
      require("timber").setup(opts)
    end
  },

  {
    'https://codeberg.org/andyg/leap.nvim',
    dependencies = {
      { 'tpope/vim-repeat' },
    },
    config = function()
      vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
      vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')

      vim.keymap.set({ 'n', 'o' }, 'gs', function()
        require('leap.remote').action {
          -- Automatically enter Visual mode when coming from Normal.
          input = vim.fn.mode(true):match('o') and '' or 'v'
        }
      end)
      -- Forced linewise version (`gS{leap}jjy`):
      vim.keymap.set({ 'n', 'o' }, 'gS', function()
        require('leap.remote').action { input = 'V' }
      end)


      vim.keymap.set({ 'x', 'o' }, 'R', function()
        require('leap.treesitter').select {
          opts = require('leap.user').with_traversal_keys('R', 'r')
        }
      end)

      -- Highly recommended: define a preview filter to reduce visual noise
      -- and the blinking effect after the first keypress
      -- (`:h leap.opts.preview`). You can still target any visible
      -- positions if needed, but you can define what is considered an
      -- exceptional case.
      -- Exclude whitespace and the middle of alphabetic words from preview:
      --   foobar[baaz] = quux
      --   ^----^^^--^^-^-^--^
      require('leap').opts.preview = function(ch0, ch1, ch2)
        return not (
          ch1:match('%s')
          or (ch0:match('%a') and ch1:match('%a') and ch2:match('%a'))
        )
      end

      -- Define equivalence classes for brackets and quotes, in addition to
      -- the default whitespace group:
      require('leap').opts.equivalence_classes = {
        ' \t\r\n', '([{', ')]}', '\'"`'
      }

      -- Use the traversal keys to repeat the previous motion without
      -- explicitly invoking Leap:
      require('leap.user').set_repeat_keys('<enter>', '<backspace>')
    end
  },

  {
    "ThePrimeagen/harpoon",
    branch       = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config       = function()
      local harpoon = require("harpoon")
      harpoon:setup({
        settings = {
          save_on_toggle = true,
        }
      })

      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
      vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

      vim.keymap.set("n", "<A-h>", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<A-t>", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<A-n>", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<A-s>", function() harpoon:list():select(4) end)
    end
  },

  {
    'mbbill/undotree',
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Undo Tree" },
    }
  }
}
