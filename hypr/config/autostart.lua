hl.on("hyprland.start", function()
	hl.exec_cmd(
		"dbus-update-activation-environment --systemd WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE XDG_SESSION_DESKTOP HYPRLAND_INSTANCE_SIGNATURE"
	)
	hl.exec_cmd(
		"systemctl --user import-environment WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE XDG_SESSION_DESKTOP HYPRLAND_INSTANCE_SIGNATURE"
	)
	hl.exec_cmd("systemctl --user restart xdg-desktop-portal-hyprland.service xdg-desktop-portal.service")
	hl.exec_cmd("systemctl --user restart linux-flow.service")
	hl.exec_cmd("gnome-keyring-daemon --start --components=secrets,pkcs11,ssh")
	hl.exec_cmd("/home/h4ni0/.local/bin/noctalia")
end)
