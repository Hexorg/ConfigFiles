local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")

local keybindings = require("keybindings")

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
	  --exclude_any = { class = { "Xfce4-appfinder", "xfce4-appfinder" }},
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = keybindings.clientkeys,
                     buttons = keybindings.clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },
    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }},
        properties = { titlebars_enabled = function(c) return not c.requests_no_titlebar end }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
		  "Xfce4-appfinder",
		  "xfce4-appfinder",
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
		  "Friends List",  -- steam friend's list
		  "Steam . News.*",
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
					 ontop = true,
                     keys = keybindings.clientkeys,
                     buttons = keybindings.clientbuttons,
                     screen = awful.screen.preferred,
					 placement = awful.placement.centered,
					 floating = true }},


    { rule_any = { name = {"Steam"}}, properties = { titlebars_enabled = false, border_width = 0 }  },
    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}