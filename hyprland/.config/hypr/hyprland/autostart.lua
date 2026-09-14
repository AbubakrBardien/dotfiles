hl.on("hyprland.start", function()
	---------------------
	-- Background Apps --
	---------------------

	-- exec-once = dbus-activation-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland DISPLAY
	hl.exec_cmd("dbus-update-activation-environment") --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP DISPLAY
	hl.exec_cmd("waybar")
	hl.exec_cmd("awww-daemon") -- Wallpaper daemon
	hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1") -- Authentication Agent
	hl.exec_cmd("hypridle")
	hl.exec_cmd("udiskie") -- Disk Automounter
	hl.exec_cmd("start_serve.sh") -- Run "serve" (the web server) to load the custom startpage
	hl.exec_cmd("gnome-keyring-daemon") --start --components=secrets

	hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Arc-Dark'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface font-name 'Inter 10.5'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'")
	hl.exec_cmd("hyprctl setcursor Adwaita 24")

	------------------
	-- Startup Apps --
	------------------
	hl.exec_cmd("wasistlos") -- WhatsApp client
	hl.exec_cmd("pcloud")
	hl.exec_cmd("vesktop --start-minimized") -- Discord client
	hl.exec_cmd("flatpak run com.valvesoftware.Steam -silent")
end)
