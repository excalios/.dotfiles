local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux
local workspace_switcher = wezterm.plugin.require 'https://github.com/MLFlexer/smart_workspace_switcher.wezterm'

wezterm.on('gui-attached', function(domain)
  local workspace = mux.get_active_workspace()
  for _, window in ipairs(mux.all_windows()) do
    if window:get_workspace() == workspace then
      window:gui_window():maximize()
    end
  end
end)

local config = {}

workspace_switcher.apply_to_config(config)
workspace_switcher.zoxide_path = '/opt/homebrew/bin/zoxide'
config.default_workspace = '~'

config.hyperlink_rules = wezterm.default_hyperlink_rules()

wezterm.on('update-right-status', function(window, pane)
  local name = window:active_key_table()
  if name then
    name = 'TABLE: ' .. name
  end
  window:set_right_status(name or '')
end)

config.leader = { key = 's', mods = 'CTRL' }
config.keys = {
  {
    key = 'r',
    mods = 'LEADER',
    action = act.ActivateKeyTable {
      name = 'resize_pane',
      one_shot = false,
    },
  },

  {
    key = 'a',
    mods = 'LEADER',
    action = act.ActivateKeyTable {
      name = 'activate_pane',
      timeout_milliseconds = 1000,
    },
  },
  {
    key = 's',
    mods = 'LEADER',
    action = workspace_switcher.switch_workspace(),
  },
  { key = '^', mods = 'CTRL', action = act.DisableDefaultAssignment },
  { key = '^', mods = 'SHIFT|CTRL', action = act.DisableDefaultAssignment },
}

config.key_tables = {
  resize_pane = {
    { key = 'h', action = act.AdjustPaneSize { 'Left', 1 } },
    { key = 'l', action = act.AdjustPaneSize { 'Right', 1 } },
    { key = 'k', action = act.AdjustPaneSize { 'Up', 1 } },
    { key = 'j', action = act.AdjustPaneSize { 'Down', 1 } },

    { key = 'Escape', action = 'PopKeyTable' },
  },

  activate_pane = {
    { key = 'h', action = act.ActivatePaneDirection 'Left' },
    { key = 'l', action = act.ActivatePaneDirection 'Right' },
    { key = 'k', action = act.ActivatePaneDirection 'Up' },
    { key = 'j', action = act.ActivatePaneDirection 'Down' },

    { key = 'x', action = act.CloseCurrentPane { confirm = true } },
  },
}

config.window_decorations = 'RESIZE'
config.window_padding = {
  top = 2,
  right = 0,
  bottom = 0,
  left = 0,
}

config.color_scheme = 'Catppuccin Macchiato'

config.font = wezterm.font 'Hack Nerd Font Mono'
config.font_size = 12

return config
