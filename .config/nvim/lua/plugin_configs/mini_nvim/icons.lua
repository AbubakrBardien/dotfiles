return {
	"echasnovski/mini.icons",
	version = false,
	config = function()
		require("mini.icons").setup {
			filetype = {
				sh = { hl = "ShellIconColor" },
				fish = { hl = "ShellIconColor" },
				python = { hl = "PythonIconColor" },
				json = { glyph = "" },
			},
			extension = {
				h = { glyph = "" },
			},
		}
		MiniIcons.mock_nvim_web_devicons()
	end,
}
-- 󰙱 󰙲  
