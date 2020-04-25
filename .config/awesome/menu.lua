local awful = require("awful")
local menubar = require("menubar")
local beautiful = require("beautiful")
local gears = require("gears")

local hotkeys_popup = require("awful.hotkeys_popup").widget

-- This is used later as the default terminal and editor to run.
local settings = require("settings")

-- Create a launcher widget and a main menu
local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end},
    { "manual", settings.terminal .. " -e man awesome" },
    { "edit config", settings.editor .. " " .. awesome.conffile },
    { "restart", awesome.restart }
 }
 
 local mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                     { "Log out", function() awesome.quit() end},
                                     { "Reboot", "reboot" },
                                     { "Shutdown", "poweroff" }
                                   }
                         })
 
 --mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
 --                                     menu = mymainmenu })
 
 -- Menubar configuration
 menubar.utils.terminal = settings.terminal -- Set the terminal for applications that require it

 root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end)
    --awful.button({ }, 4, awful.tag.viewnext),
    --awful.button({ }, 5, awful.tag.viewprev)
))

return mymainmenu