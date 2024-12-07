return {
	"echasnovski/mini.icons",
	version = false,
	config = function()
		require("mini.icons").setup {
			extension = {
				h = { glyph = "" },
				py = { hl = "PythonIconColor" }, -- custom highlight group
				json = { glyph = "" },
			},
		}
		MiniIcons.mock_nvim_web_devicons()
	end,
}
-- 󰙱 󰙲  
