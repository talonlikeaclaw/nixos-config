local wezterm = require("wezterm")
local act = wezterm.action
local sessions = wezterm.plugin.require("https://github.com/abidibo/wezterm-sessions")

local config = wezterm.config_builder()

config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 2000 }

config.color_scheme = "Catppuccin Mocha"

config.colors = {
  foreground = "#cdd6f4",
  background = "#1e1e2e",
  cursor_bg = "#f5e0dc",
  cursor_border = "#f5e0dc",
  selection_bg = "#f5e0dc",
  selection_fg = "#1e1e2e",
  ansi = {
    "#45475a",
    "#f38ba8",
    "#a6e3a1",
    "#f9e2af",
    "#89b4fa",
    "#f5c2e7",
    "#94e2d5",
    "#bac2de",
  },
  brights = {
    "#585b70",
    "#f38ba8",
    "#a6e3a1",
    "#f9e2af",
    "#89b4fa",
    "#f5c2e7",
    "#94e2d5",
    "#a6adc8",
  },
  indexed = {
    [16] = "#f38ba8",
    [17] = "#f5e0dc",
  },
  scrollbar_thumb = "#585b70",
  split = "#313244",
  tab_bar = {
    background = "#181825",
    active_tab = {
      bg_color = "#1e1e2e",
      fg_color = "#cdd6f4",
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color = "#313244",
      fg_color = "#585b70",
    },
    new_tab = {
      bg_color = "#181825",
      fg_color = "#585b70",
    },
  },
}

config.colors.compose_cursor = "orange"

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = true
config.tab_max_width = 32

config.font = wezterm.font("Maple Mono NF")
config.font_size = 11.5

config.window_padding = {
  left = 4,
  right = 4,
  top = 4,
  bottom = 4,
}

config.window_background_opacity = 0.97

config.scrollback_lines = 10000
config.enable_scroll_bar = false

config.audible_bell = "Disabled"
config.visual_bell = {
  fade_in_duration_ms = 0,
  fade_out_duration_ms = 0,
}

config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.cursor_blink_rate = 0
config.default_cursor_style = "BlinkingBlock"

config.window_close_confirmation = "NeverPrompt"

config.default_prog = { "zsh", "-l" }

config.enable_wayland = true

config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = act.Nop,
  },
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = act.OpenLinkAtMouseCursor,
  },
}

wezterm.on("update-right-status", function(window, pane)
  local leader = ""
  if window:leader_is_active() then
    leader = "LEADER"
  end
  window:set_right_status(leader)
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, cfg, hover, max_width)
  local title = tab.tab_title
  if not title or #title == 0 then
    title = tab.active_pane.title
  end
  title = tab.tab_index + 1 .. ": " .. title
  if #title > max_width then
    title = wezterm.truncate_right(title, max_width)
  end
  return title
end)

config.keys = {
  {
    key = "Space",
    mods = "LEADER|CTRL",
    action = act.SendKey({ key = "Space", mods = "CTRL" }),
  },
  {
    key = "\\",
    mods = "LEADER",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "-",
    mods = "LEADER",
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "LeftArrow",
    mods = "ALT",
    action = act.ActivatePaneDirection("Left"),
  },
  {
    key = "RightArrow",
    mods = "ALT",
    action = act.ActivatePaneDirection("Right"),
  },
  {
    key = "UpArrow",
    mods = "ALT",
    action = act.ActivatePaneDirection("Up"),
  },
  {
    key = "DownArrow",
    mods = "ALT",
    action = act.ActivatePaneDirection("Down"),
  },
  {
    key = "h",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Left"),
  },
  {
    key = "j",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Down"),
  },
  {
    key = "k",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Up"),
  },
  {
    key = "l",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Right"),
  },
  {
    key = "LeftArrow",
    mods = "LEADER",
    action = act.AdjustPaneSize({ "Left", 5 }),
  },
  {
    key = "RightArrow",
    mods = "LEADER",
    action = act.AdjustPaneSize({ "Right", 5 }),
  },
  {
    key = "UpArrow",
    mods = "LEADER",
    action = act.AdjustPaneSize({ "Up", 5 }),
  },
  {
    key = "DownArrow",
    mods = "LEADER",
    action = act.AdjustPaneSize({ "Down", 5 }),
  },
  {
    key = "LeftArrow",
    mods = "SHIFT",
    action = act.ActivateTabRelative(-1),
  },
  {
    key = "RightArrow",
    mods = "SHIFT",
    action = act.ActivateTabRelative(1),
  },
  {
    key = "[",
    mods = "LEADER",
    action = act.ActivateTabRelative(-1),
  },
  {
    key = "]",
    mods = "LEADER",
    action = act.ActivateTabRelative(1),
  },
  {
    key = "t",
    mods = "LEADER",
    action = act.SpawnTab("CurrentPaneDomain"),
  },
  {
    key = "q",
    mods = "LEADER",
    action = act.CloseCurrentPane({ confirm = false }),
  },
  {
    key = "w",
    mods = "LEADER",
    action = act.CloseCurrentTab({ confirm = false }),
  },
  {
    key = "z",
    mods = "LEADER",
    action = act.TogglePaneZoomState,
  },
  {
    key = "r",
    mods = "LEADER",
    action = act.PromptInputLine({
      description = "Set tab title",
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },
  {
    key = "F5",
    mods = "LEADER",
    action = act.ReloadConfiguration,
  },
  {
    key = "c",
    mods = "LEADER",
    action = act.ActivateCopyMode,
  },
  {
    key = "u",
    mods = "LEADER",
    action = act.Search("CurrentSelectionOrEmptyString"),
  },
  {
    key = "s",
    mods = "LEADER",
    action = act.SpawnCommandInNewWindow({ args = { "nvim", "-R", "-" } }),
  },
  {
    key = "b",
    mods = "LEADER",
    action = act.PromptInputLine({
      description = "Broadcast to panes",
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          local tabs = window:mux_window():tabs()
          for _, tab in ipairs(tabs) do
            local panes = tab:panes()
            for _, p in ipairs(panes) do
              p:send_text(line .. "\r")
            end
          end
        end
      end),
    }),
  },
  {
    key = "o",
    mods = "LEADER",
    action = act.EmitEvent("load_session"),
  },
  {
    key = "R",
    mods = "LEADER|SHIFT",
    action = act.EmitEvent("restore_session"),
  },
  {
    key = "f",
    mods = "LEADER",
    action = act.EmitEvent("fork_session"),
  },
  {
    key = "D",
    mods = "LEADER|SHIFT",
    action = act.EmitEvent("delete_session"),
  },
  {
    key = "E",
    mods = "LEADER|SHIFT",
    action = act.EmitEvent("edit_session"),
  },
  {
    key = "a",
    mods = "LEADER",
    action = act.EmitEvent("toggle_autosave"),
  },
  {
    key = "S",
    mods = "LEADER|SHIFT",
    action = act.EmitEvent("save_session"),
  },
  {
    key = "n",
    mods = "LEADER",
    action = act.PromptInputLine({
      description = "New workspace name",
      action = wezterm.action_callback(function(window, pane, line)
        if line and #line > 0 then
          window:perform_action(act.SwitchToWorkspace({ name = line }), pane)
        end
      end),
    }),
  },
}

for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = act.ActivateTab(i - 1),
  })
end

local copy_mode_keys = {
  { key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
  { key = "q", mods = "NONE", action = act.CopyMode("Close") },
  { key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
  { key = "y", mods = "NONE", action = act.Multiple({ act.CopyTo("Clipboard"), act.CopyMode("Close") }) },
  { key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
  { key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
  { key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
  { key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
  { key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
  { key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
  { key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
  { key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },
  { key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
  { key = "$", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
  { key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
  { key = "G", mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
  { key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
  { key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
}

local default_tables = wezterm.gui.default_key_tables()
for _, default in ipairs(default_tables) do
  if default.name == "copy_mode" then
    local seen = {}
    for _, override in ipairs(copy_mode_keys) do
      seen[override.key] = true
    end
    for _, binding in ipairs(default.keys) do
      if not seen[binding.key] then
        table.insert(copy_mode_keys, binding)
      end
    end
    break
  end
end

config.key_tables = {
  copy_mode = copy_mode_keys,
}

config.launch_menu = {
  {
    label = "mainframe",
    args = { "zsh", "-l" },
  },
}

sessions.apply_to_config(config, {
  auto_save_interval_s = 30,
})

return config
