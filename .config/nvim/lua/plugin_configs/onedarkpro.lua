return {
	-- Favourite Theme
	"olimorris/onedarkpro.nvim",
	priority = 1000, -- Ensure it loads first
	config = function()
		require("onedarkpro").setup {
			colors = { onedark = { bg = "#1d1f24" } },
		}
	end,
}
