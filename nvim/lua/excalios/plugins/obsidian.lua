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
      {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
          image = {
            resolve = function(path, src)
              if require("obsidian.api").path_is_note(path) then
                return require("obsidian.api").resolve_image_path(src)
              end
            end,
          },
        },
      }
    },
    keys = {
      { '<leader>of', "<cmd>Obsidian quick_switch<CR>", desc="[O]bsidian [F]ind" },
      { '<leader>olg', "<cmd>Obsidian search<CR>", desc="[O]bsidian [L]ive [G]rep" },
      { '<leader>ot', "<cmd>Obsidian today<CR>", desc="[O]bsidian [T]oday notes" },
      { '<leader>oii', "<cmd>Obsidian paste_img<CR>", desc="[O]bsidian [I]nsert [I]mage" },
    },
    opts = {
      legacy_commands = false,
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
      daily_notes = {
        folder = "09 - Dailies",
        date_format = "%Y-%m-%d",
        alias_format = "%B %-d, %Y",
        default_tags = { "daily" },
        workdays_only = false,
      },
      new_notes_location = "current_dir",
      ---@param title string|?
      ---@return string
      note_id_func = function(title)
        local suffix = ""
        if title ~= nil then
          suffix = title
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return suffix
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
      attachments = {
        img_folder = "assets/imgs",
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
  },

  {
      "jalvesaq/zotcite",
      dependencies = {
          "nvim-treesitter/nvim-treesitter",
          "nvim-telescope/telescope.nvim",
      },
      config = function ()
          require("zotcite").setup({
              -- your options here (see doc/zotcite.txt)
          })
      end
  },
}
