return {
	"echasnovski/mini.icons",
	version = false,
	config = function()
		require("mini.icons").setup {
			filetype = {
				fish = { hl = "ShellIconColor" },
				json = { glyph = "" },
				lua = { hl = "MiniIconsBlue" },
				python = { hl = "PythonIconColor" },
				sh = { hl = "ShellIconColor" },
			},
			extension = {
				h = { glyph = "" },
			},
			lsp = {
				["function"] = { glyph = "" },
				field = { glyph = "" },
				property = { glyph = "" },
				text = { glyph = "󰉿" },
				variable = { hl = "MiniIconsGreen" },
			},
		}
		MiniIcons.mock_nvim_web_devicons()
	end,
}
-- 󰙱 󰙲  
