local beautiful = require("beautiful")
local gears = require("gears")

local settings = {
    editor = "gvim",
    terminal = "xfce4-terminal",
    wallpaper = "../Pictures/341416.png",
    modkey = "Mod4"
}

-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_xdg_config_home() .. "awesome/theme/theme.lua")
beautiful.wallpaper = gears.filesystem.get_xdg_config_home() .. settings.wallpaper



return settings