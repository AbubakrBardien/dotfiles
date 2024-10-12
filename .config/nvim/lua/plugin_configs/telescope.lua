local common_deps = require("dependency_list")

return {
	{
		-- Search Tool / Fuzzy Finder
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			common_deps["nvim_web_devicons"],
		},
		config = function()
			require("telescope").setup {
				defaults = {
					sorting_strategy = "ascending",
					layout_config = {
						prompt_position = "top",
						height = 0.65,
						width = 0.85,
					},
				},
			}
		end,
	},
}
