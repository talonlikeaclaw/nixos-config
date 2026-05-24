local wezterm = require("wezterm")

local function spawn_mainframe()
  local mux = wezterm.mux
  local window = mux.get_window(wezterm.mux.get_active_workspace())

  if not window then
    window = mux.spawn_local({
      args = { "zsh" },
    })
  end

  return window
end

return spawn_mainframe