------------------
--- Animations ---
------------------

hl.config {
	animations = {
		enabled = true,
	},
}

-- stylua: ignore start

-- bezier = myBezier, 0.05, 0.9, 0.1, 1.05	# Default
-- bezier = windowAnim, 1, 0, 0, 1	# Very Cool, but too distracting

hl.curve("windowAnim",    { type = "bezier", points = {{ 0, 1 }, { 0, 1 }}})
hl.curve("workspaceAnim", { type = "bezier", points = {{ 0, 0 }, { 0, 1 }}})

hl.animation { leaf = "windows",     enabled = true, speed = 7, bezier = "windowAnim" }
hl.animation { leaf = "windowsOut",  enabled = true, speed = 7, bezier = "default", style = "popin 70%" }
hl.animation { leaf = "border",      enabled = true, speed = 1, bezier = "default" }
hl.animation { leaf = "borderangle", enabled = true, speed = 8, bezier = "default" }
hl.animation { leaf = "fade",        enabled = true, speed = 7, bezier = "default" }
hl.animation { leaf = "workspaces",  enabled = true, speed = 4, bezier = "workspaceAnim" }

-- stylua: ignore end
