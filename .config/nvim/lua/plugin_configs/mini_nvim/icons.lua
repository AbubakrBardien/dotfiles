return {
	"echasnovski/mini.icons",
	version = false,
	config = function()
		require("mini.icons").setup {
			extension = {
				h = { glyph = "󰙲", hl = "MiniIconsAzure" },
				py = { hl = "PythonIconColor" }, -- custom highlight group
			},
		}
		MiniIcons.mock_nvim_web_devicons()
	end,
}
