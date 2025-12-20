local configGoTest = { -- Specify configuration
  runner = "gotestsum",
  args = { "-v", "-race", "-count=1", "-p=1" },
}

-- NOTE: Might change to neotest, vim-dap
return {
  -- {
  --   'puremourning/vimspector',
  --   keys = {
  --     { "<leader>ds", "<cmd>VimspectorContinue<CR>", desc = "Vimspector Continue" },
  --     { "<leader>db", "<cmd>VimspectorBalloonEval<CR>", desc = "Vimspector Balloon Eval" },
  --   }
  -- },

  {
    'szw/vim-maximizer',
    keys = {
      { "<A-m>", "<cmd>MaximizerToggle!<CR>", desc = "Maximizer Toggle" },
    }
  },

  -- {
  --   'vim-test/vim-test',
  --   keys = {
  --     {"t<C-f>", "<cmd>TestFile<CR>", desc = "Test File"},
  --     {"t<C-n>", "<cmd>TestNearest<CR>", desc = "Test Nearest"},
  --     {"t<C-s>", "<cmd>TestSuite<CR>", desc = "Test Suite"},
  --     {"t<C-l>", "<cmd>TestLast<CR>", desc = "Test Last"},
  --   },
  --   config = function()
  --     vim.g["test#strategy"] = "neovim"
  --     vim.g["test#preserve_screen"] = 1
  --     vim.g["test#neovim#term_position"] = "vert"
  --     vim.g["test#echo_command"] = 0
  --
  --     vim.g["test#php#phpunit#executable"] = "php artisan test"
  --     vim.g["test#go#gotest#options"] = "-v"
  --   end
  -- },

  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      { "nvim-treesitter/nvim-treesitter", branch = "main" }, -- Optional

      "nvim-neotest/neotest-plenary",
      -- "nvim-neotest/neotest-vim-test",
      {
        "fredrikaverpil/neotest-golang",
        version = "*", -- Optional, but recommended
        dependencies = {
          {
            "leoluz/nvim-dap-go",
            opts = {},
          },
        },
        build = function()
          vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait() -- Optional, but recommended
          vim.cmd([[:TSUpdate go]])                                               -- Optional
        end,
      },
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-jest",
    },
    config = function()
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message =
                diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      require("neotest").setup({
        consumers = {
          timber = require("timber.watcher.sources.neotest").consumer,
        },
        adapters = {
          require("neotest-golang")(configGoTest), -- Registration
          require("neotest-python"),
          -- require("neotest-vim-test")({
          --   ignore_file_types = { "golang" },
          -- }),
          require("neotest-jest")({
            jestCommand = "npm test --",
            jestArguments = function(defaultArguments, context)
              return defaultArguments
            end,
            jestConfigFile = "custom.jest.config.ts",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
            isTestFile = require("neotest-jest.jest-util").defaultIsTestFile,
          }),
        },
      })
    end,
    keys = {
      { "<leader>ta", function() require("neotest").run.attach() end,                                      desc = "[t]est [a]ttach" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,                       desc = "[t]est run [f]ile" },
      { "<leader>tA", function() require("neotest").run.run(vim.uv.cwd()) end,                             desc = "[t]est [A]ll files" },
      { "<leader>tS", function() require("neotest").run.run({ suite = true }) end,                         desc = "[t]est [S]uite" },
      { "<leader>tn", function() require("neotest").run.run() end,                                         desc = "[t]est [n]earest" },
      { "<leader>tl", function() require("neotest").run.run_last() end,                                    desc = "[t]est [l]ast" },
      { "<leader>ts", function() require("neotest").summary.toggle() end,                                  desc = "[t]est [s]ummary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end,  desc = "[t]est [o]utput" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end,                             desc = "[t]est [O]utput panel" },
      { "<leader>tt", function() require("neotest").run.stop() end,                                        desc = "[t]est [t]erminate" },
      { "<leader>td", function() require("neotest").run.run({ suite = false, strategy = "dap" }) end,      desc = "Debug nearest test" },
      { "<leader>tD", function() require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" }) end, desc = "Debug current file" },
    },
  },

  {
    "mistweaverco/kulala.nvim",
    keys = {
      { "<leader>Rs", desc = "Send request" },
      { "<leader>Ra", desc = "Send all requests" },
      { "<leader>Rb", desc = "Open scratchpad" },
    },
    ft = { "http", "rest" },
    opts = {
      -- your configuration comes here
      global_keymaps = true,
    },
  },

  -- DAP setup
  {
    "https://codeberg.org/mfussenegger/nvim-dap",
    event = "VeryLazy",
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "toggle [d]ebug [b]reakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "[d]ebug [B]reakpoint" },
      { "<leader>dc", function() require("dap").continue() end,                                             desc = "[d]ebug [c]ontinue (start here)" },
      { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "[d]ebug [C]ursor" },
      { "<leader>dg", function() require("dap").goto_() end,                                                desc = "[d]ebug [g]o to line" },
      { "<leader>do", function() require("dap").step_over() end,                                            desc = "[d]ebug step [o]ver" },
      { "<leader>dO", function() require("dap").step_out() end,                                             desc = "[d]ebug step [O]ut" },
      { "<leader>di", function() require("dap").step_into() end,                                            desc = "[d]ebug [i]nto" },
      { "<leader>dj", function() require("dap").down() end,                                                 desc = "[d]ebug [j]ump down" },
      { "<leader>dk", function() require("dap").up() end,                                                   desc = "[d]ebug [k]ump up" },
      { "<leader>dl", function() require("dap").run_last() end,                                             desc = "[d]ebug [l]ast" },
      { "<leader>dp", function() require("dap").pause() end,                                                desc = "[d]ebug [p]ause" },
      { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "[d]ebug [r]epl" },
      { "<leader>dR", function() require("dap").clear_breakpoints() end,                                    desc = "[d]ebug [R]emove breakpoints" },
      { "<leader>ds", function() require("dap").session() end,                                              desc = "[d]ebug [s]ession" },
      { "<leader>dt", function() require("dap").terminate() end,                                            desc = "[d]ebug [t]erminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "[d]ebug [w]idgets" },
    },
    config = function(_, opts)
      local dap = require('dap')
      dap.adapters.node2 = {
        type = 'executable',
        command = 'node',
        args = { os.getenv('HOME') .. '/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js' },
      }
      dap.configurations.javascript = {
        {
          name = 'Launch',
          type = 'node2',
          request = 'launch',
          program = '${file}',
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = 'inspector',
          console = 'integratedTerminal',
        },
        {
          -- For this to work you need to make sure the node process is started with the `--inspect` flag.
          name = 'Attach to process',
          type = 'node2',
          request = 'attach',
          processId = require 'dap.utils'.pick_process,
        },
      }
      dap.configurations.typescript = {
        {
          name = 'Launch',
          type = 'node2',
          request = 'launch',
          program = '${file}',
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = 'inspector',
          console = 'integratedTerminal',
        },
        {
          -- For this to work you need to make sure the node process is started with the `--inspect` flag.
          name = 'Attach to process',
          type = 'node2',
          request = 'attach',
          processId = require 'dap.utils'.pick_process,
          outFiles = { "${workspaceFolder}/bin/**/*.js" },
        },
      }
    end,
  },

  -- DAP UI setup
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "https://codeberg.org/mfussenegger/nvim-dap",
    },
    opts = {},
    config = function(_, opts)
      -- setup dap config by VsCode launch.json file
      -- require("dap.ext.vscode").load_launchjs()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
    keys = {
      { "<leader>du", function() require("dapui").toggle({}) end, desc = "[d]ap [u]i" },
      { "<leader>de", function() require("dapui").eval() end,     desc = "[d]ap [e]val" },
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {},
  },

  {
    'mfussenegger/nvim-dap-python',
    dependencies = {
      "https://codeberg.org/mfussenegger/nvim-dap",
    },
    config = function()
      require("dap-python").setup("uv")
    end
  }
}
