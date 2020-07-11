-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

require("layouts")
require("errors")

-- run autostart script
awful.spawn.with_shell(gears.filesystem.get_xdg_config_home() .. "/awesome/autorun.sh")

require("screenInit")
require("rules")
require("clientSignals")