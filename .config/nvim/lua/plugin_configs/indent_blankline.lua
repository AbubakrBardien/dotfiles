return {
	"lukas-reineke/indent-blankline.nvim",
	config = function()
		require("ibl").setup {
			exclude = { filetypes = { "dashboard" } },
			indent = { char = "▏" },
			whitespace = { highlight = { "Whitespace" } },
			scope = { enabled = false },
		}
	end,
}
