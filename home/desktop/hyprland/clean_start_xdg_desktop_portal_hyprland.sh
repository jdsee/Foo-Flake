#!/usr/bin/env bash
sleep 1
systemctl --user stop xdg-desktop-portal-hyprland
systemctl --user stop xdg-desktop-portal-wlr
systemctl --user stop xdg-desktop-portal-gtk
systemctl --user restart xdg-desktop-portal

sleep 1
systemctl --user start xdg-desktop-portal-hyprland
systemctl --user start xdg-desktop-portal-wlr
systemctl --user start xdg-desktop-portal-gtk
