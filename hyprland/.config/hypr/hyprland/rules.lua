----------------------------------
--- Window And Workspace Rules ---
----------------------------------

local globals = require("hyprland.global_variables")

hl.window_rule {
	name = "Transparent Terminal",
	match = { class = "^(com.mitchellh.ghostty)$" },
	opacity = 0.8,
	-- opacity = 1
}

hl.window_rule {
	name = "Opaque Neovim", -- (Overrides general Terminal rule)
	match = {
		class = "^(com.mitchellh.ghostty)$",
		title = ".*( nvim)$",
	},
	opacity = 1,
}

hl.window_rule {
	name = "'Picture-in-Picture' Mode",
	match = { title = "^(Picture in picture)$" },
	float = true,
	pin = true,
	size = { "monitor_w*0.25", "monitor_h*0.25" },
	move = { "monitor_w*0.744", "monitor_h*0.012" },
	border_color = "rgba(595959aa)",
}

-- Considering removing Thunderbird entirely
-- window_rule {
-- 	name = Thunderbird Specifications # (Floating all windows except the main one)
--     match:class = ^(thunderbird)$
--     match:title = ^(?!(Mozilla Thunderbird)$)$
--     float = on
--     size = monitor_w*0.5 monitor_h*0.5
--     border_color = rgba(595959aa)
-- }

hl.window_rule {
	name = "Makes Calculator a floating window",
	match = { class = "^(" .. globals.calculator .. ")$" },
	float = true,
	size = { 448, 497 },
	move = { "monitor_w*0.5-400", "monitor_h*0.5-400" },
}

-- "no_gaps_when_only" behavior
hl.workspace_rule {
	workspace = "w[tv1]",
	gaps_out = 0,
	gaps_in = 0,
	no_border = true,
	no_rounding = true,
}
hl.workspace_rule {
	workspace = "f[1]",
	gaps_out = 0,
	gaps_in = 0,
	no_border = true,
	no_rounding = true,
}
