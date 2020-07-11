#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

run /usr/libexec/polkit-gnome-authentication-agent-1
run nm-applet
run xfce4-power-manager
run blueman-applet
run compton -b --config ${HOME}/.config/compton/compton.conf
