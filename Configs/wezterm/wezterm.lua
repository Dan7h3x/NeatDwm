local wez = require("wezterm")
local utils = require("lua.util")
local appearance = require("lua.ui")
local mappings = require("lua.maps")
local bar = wez.plugin.require("https://github.com/adriankarlen/bar.wezterm")

local platform = utils.platform()
local c = {}

if wez.config_builder then
  c = wez.config_builder()
end

-- General configurations
c.font = wez.font("CaskaydiaMono Nerd Font", { weight = "Medium" })
c.font_rules = {
  {
    italic = true,
    font = wez.font("CaskaydiaMono Nerd Font", { weight = "Medium", italic = true }),
  },
}
c.font_size = 12
c.command_palette_font_size = 13
c.command_palette_rows = 15
c.default_prog = platform.is_win and { "pwsh", "-NoLogo" } or { "zsh" }
c.adjust_window_size_when_changing_font_size = false
c.audible_bell = "Disabled"
c.scrollback_lines = 3000
c.default_workspace = "main"
c.window_background_opacity = 0.8
c.max_fps = 240
c.enable_wayland = true
-- appearance
appearance.apply_to_config(c)

-- keys
mappings.apply_to_config(c)

-- bar
bar.apply_to_config(c, {
  position = "top",
  max_width = 25,
  padding = {
    left = 1,
    right = 1,
  },
  separator = {
    space = 1,
    left_icon = wez.nerdfonts.fa_long_arrow_right,
    right_icon = wez.nerdfonts.fa_long_arrow_left,
    field_icon = wez.nerdfonts.indent_line,
  },
  modules = {
    tabs = {
      active_tab_fg = 4,
      inactive_tab_fg = 6,
    },
    workspace = {
      enabled = true,
      icon = wez.nerdfonts.cod_window,
      color = 8,
    },
    leader = {
      enabled = true,
      icon = wez.nerdfonts.oct_rocket,
      color = 2,
    },
    pane = {
      enabled = true,
      icon = wez.nerdfonts.cod_multiple_windows,
      color = 7,
    },
    username = {
      enabled = true,
      icon = wez.nerdfonts.fa_user,
      color = 6,
    },
    hostname = {
      enabled = true,
      icon = wez.nerdfonts.cod_server,
      color = 8,
    },
    clock = {
      enabled = true,
      icon = wez.nerdfonts.md_calendar_clock,
      color = 5,
    },
    cwd = {
      enabled = true,
      icon = wez.nerdfonts.oct_file_directory,
      color = 7,
    },
    spotify = {
      enabled = false,
      icon = wez.nerdfonts.fa_spotify,
      color = 3,
      max_width = 64,
      throttle = 15,
    },
  },
})

return c
