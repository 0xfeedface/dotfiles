local wezterm = require 'wezterm'

local background_color = '#002732';
local act = wezterm.action

return {
  font = wezterm.font {
    family = 'Iosevka Fixed Slab',
    weight = 'Medium',
    harfbuzz_features = { 'cv82=2', 'cv90=3', 'cv91=1', 'cv98=3' },
  },
  colors = {
    foreground = '#8b9c9d',
    background = background_color,
    cursor_fg = background_color,
    cursor_bg = '#9ba9a9',
    cursor_border = cursor_bg,
    ansi = {
      '#01313d',
      '#e63c36',
      '#8da100',
      '#be910d',
      '#3393da',
      '#dc3f8a',
      '#35aaa0',
      '#f7f0dd',
    },
    brights = {
      '#002732',
      '#d4541e',
      '#60767d',
      '#6c838a',
      '#8b9c9d',
      '#7478cd',
      '#9ba9a9',
      '#ffffeb',
    }
  },
  font_size = 14,
  adjust_window_size_when_changing_font_size = false,
  audible_bell = 'Disabled',
  hide_tab_bar_if_only_one_tab = true,
  mouse_bindings = {
    {
      event = { Down = { streak = 1, button = { WheelUp = 1 } } },
      mods = 'NONE',
      action = act.ScrollByLine(-1),
    },
    {
      event = { Down = { streak = 1, button = { WheelDown = 1 } } },
      mods = 'NONE',
      action = act.ScrollByLine(1),
    },
  }
}
