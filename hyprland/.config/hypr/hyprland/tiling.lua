--------------
--- Tiling ---
--------------

hl.config {
	general = {
		gaps_in = 5,
		gaps_out = 10,

		border_size = 2,

		col = {
			active_border = {
				colors = { "rgba(00ff99ee)", "rgba(33ccffee)" },
				angle = 45,
			},
			inactive_border = "rgba(595959aa)",
		},

		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},

	dwindle = {
		preserve_split = true,
		force_split = 2,
	},
}
