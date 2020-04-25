local beautiful = require("beautiful")
local gears = require("gears")

local settings = {
    editor = "gvim",
    terminal = "xfce4-terminal",
    wallpaper = "../Pictures/341416.png",
    modkey = "Mod4"
}

-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.useless_gap = 16
beautiful.master_width_factor = 0.40
beautiful.column_count = 2
beautiful.notification_font = "sans 12"
beautiful.wallpaper = gears.filesystem.get_xdg_config_home() .. settings.wallpaper
beautiful.border_width = 0


return settings