-------------
--- Input ---
-------------

-- Global Input Settings
hl.config {
	input = {
		kb_layout = "us",
		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
		scroll_method = "2fg", -- 2 finger scroll
		scroll_factor = 0,

		touchpad = {
			natural_scroll = true,
			scroll_factor = 0.18,
			tap_button_map = "lmr",
		},
	},
	gestures = {
		workspace_swipe_distance = 700,
	},
}

-- Settings for Mouse. Overriding "input" settings
hl.device {
	name = "logitech-g502-x",
	scroll_factor = 1.0,
}
hl.device {
	name = "logitech-g502-x-keyboard-1",
	scroll_factor = 1.0,
}

hl.gesture { fingers = 3, direction = "horizontal", action = "workspace" }
hl.gesture { fingers = 4, direction = "horizontal", action = "workspace" }
