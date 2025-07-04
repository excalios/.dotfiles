return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    lazy = false,
    ft = "markdown",
    event = {
      "BufReadPre /Users/v01d/Library/Mobile Documents/iCloud~md~obsidian/Documents/Personal/**/*.md",
      "BufNewFile /Users/v01d/Library/Mobile Documents/iCloud~md~obsidian/Documents/Personal/**/*.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { '<leader>of', "<cmd>ObsidianQuickSwitch<CR>", desc="[O]bsidian [F]ind" },
      { '<leader>olg', "<cmd>ObsidianSearch<CR>", desc="[O]bsidian [L]ive [G]rep" },
      { '<leader>ot', "<cmd>ObsidianToday<CR>", desc="[O]bsidian [T]oday notes" },
    },
    opts = {
      ui = { enable = false },
      workspaces = {
        {
          name = "personal",
          path = "/Users/v01d/Library/Mobile Documents/iCloud~md~obsidian/Documents/Personal",
        },
      },
      completion = {
        nvim_cmp = true,
        min_chars = 0,
      },
      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ["<leader>ch"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ["<CR>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
        ["<leader>of"] = {
          action = "<cmd>ObsidianSearch<CR>",
        },
        ["<leader>oii"] = {
          action = "<cmd>ObsidianPasteImg<CR>",
        },
        ["<leader>on"] = {
          action = ":ObsidianNew ",
        },
        ["<leader>ot"] = {
          action = "<cmd>ObsidianToday<CR>",
        },
      },
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "09 - Dailies",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = "%Y-%m-%d",
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = "%B %-d, %Y",
        -- Optional, default tags to add to each new daily note created.
        default_tags = { "daily" },
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = nil
      },
      picker = {
        -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
        name = "telescope.nvim",
        -- Optional, configure key mappings for the picker. These are the defaults.
        -- Not all pickers support all mappings.
        mappings = {
          -- Create a new note from your query.
          new = "<C-x>",
          -- Insert a link to the selected note.
          insert_link = "<C-l>",
        },
      },
      -- Optional, customize how note IDs are generated given an optional title.
      ---@param title string|?
      ---@return string
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return os.date('%Y%m%d%H%M') .. " " .. suffix
      end,
       -- Optional, customize how note file names are generated given the ID, target directory, and title.
       ---@param spec { id: string, dir: obsidian.Path, title: string|? }
       ---@return string|obsidian.Path The full path to the new note.
       note_path_func = function(spec)
         -- This is equivalent to the default behavior.
         local path = spec.dir / tostring(spec.id)
         return path:with_suffix(".md")
       end,
      -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
    -- URL it will be ignored but you can customize this behavior here.
    ---@param url string
    follow_url_func = function(url)
      -- Open the URL in the default web browser.
      -- vim.fn.jobstart({"open", url})  -- Mac OS
      -- vim.fn.jobstart({"xdg-open", url})  -- linux
      -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
      vim.ui.open(url) -- need Neovim 0.10.0+
    end,
       -- Sets how you follow images
      ---@param img string
      follow_img_func = function(img)
        vim.ui.open(img)
        -- vim.ui.open(img, { cmd = { "loupe" } })
      end,
      open = {
        func = function(uri)
          vim.ui.open(uri, { cmd = { "open", "-a", "/Applications/Obsidian.app" } })
        end
      },
      attachments = {
        img_folder = "98 - Assets/imgs",
        ---@param client obsidian.Client
        ---@param path obsidian.Path the absolute path to the image file
        ---@return string
        img_text_func = function(client, path)
          path = client:vault_relative_path(path) or path
          return string.format("![[%s]]", path)
        end,
      },
    },
  },

  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    priority = 49,
    dependencies = {
      "catppuccin/nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      preview = {
          -- enable_hybrid_mode = true,
          linewise_hybrid_mode = true,
          hybrid_modes = {"n", "c", "t"},
          icon_provider = "mini", -- "mini" or "devicons"
      },
      markdown = {
        list_items = {
            shift_width = function (buffer, item)
                --- Reduces the `indent` by 1 level.
                ---
                ---         indent                      1
                --- ------------------------- = 1 ÷ --------- = new_indent
                --- indent * (1 / new_indent)       new_indent
                ---
                local parent_indnet = math.max(1, item.indent - vim.bo[buffer].shiftwidth);

                return (item.indent) * (1 / (parent_indnet * 2));
            end,
            marker_minus = {
                add_padding = function (_, item)
                    return item.indent > 1;
                end
            }
        }
      }
    }
  }
}
