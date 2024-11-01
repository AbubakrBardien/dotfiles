-- Based on the Material theme provided by lualine.nvim

local colors = {
	fg = "#eeffff",
	bg = "#263238",
	blue = "#96b8ff",
	green = "#86d16f",
	purple = "#c792ea",
	red1 = "#f07178",
	red2 = "#ff5370",
	orange = "#D8B576",
	gray1 = "#314549",
	gray2 = "#24262b",
	gray3 = "#3a3f42",
}

return {
	normal = {
		a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
		b = { fg = colors.blue, bg = colors.gray3, gui = "bold" },
		c = { fg = colors.fg, bg = colors.gray2 },
	},
	insert = {
		a = { fg = colors.bg, bg = colors.green, gui = "bold" },
		b = { fg = colors.green, bg = colors.gray3, gui = "bold" },
	},
	visual = {
		a = { fg = colors.bg, bg = colors.purple, gui = "bold" },
		b = { fg = colors.purple, bg = colors.gray3, gui = "bold" },
	},
	replace = {
		a = { fg = colors.bg, bg = colors.red1, gui = "bold" },
		b = { fg = colors.red1, bg = colors.gray3, gui = "bold" },
	},
	command = {
		a = { fg = colors.bg, bg = colors.orange, gui = "bold" },
		b = { fg = colors.orange, bg = colors.gray3, gui = "bold" },
	},
	terminal = {
		a = { fg = colors.bg, bg = colors.green, gui = "bold" },
		b = { fg = colors.orange, bg = colors.gray3, gui = "bold" },
	},
	inactive = {
		a = { fg = colors.fg, bg = colors.bg, gui = "bold" },
		b = { fg = colors.fg, bg = colors.bg },
		c = { fg = colors.fg, bg = colors.gray2 },
	},
}
