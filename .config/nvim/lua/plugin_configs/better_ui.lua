return {
	"stevearc/dressing.nvim",
	config = function()
		require("dressing").setup {
			select = {
				telescope = require("telescope.themes").get_cursor {
					layout_config = {
						width = 0.36,
						height = 7,
					},
				},
			},
		}
	end,
}
