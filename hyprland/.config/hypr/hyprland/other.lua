-------------
--- Other ---
-------------

local globals = require("hyprland.global_variables")

hl.config {
	misc = {
		force_default_wallpaper = 0, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = true,
		enable_swallow = true,
		swallow_regex = "^(" .. globals.terminal .. "|" .. globals.fileManager .. ")$",
		swallow_exception_regex = ".*\b(wev)\b.*",
	},
}
