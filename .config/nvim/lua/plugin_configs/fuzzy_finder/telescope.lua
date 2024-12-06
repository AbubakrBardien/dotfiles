local common_deps = require("dependency_list")

local size_keymaps = { height = 24, width = 95 }
local size_fuzzy_find = { height = 0.65, width = 0.65 }

return {
	-- Search Tool / Fuzzy Finder
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		common_deps["mini_icons"],
	},
	config = function()
		require("telescope").setup {
			defaults = {
				sorting_strategy = "ascending",
				layout_config = {
					prompt_position = "top",
					height = 0.68,
					width = 0.85,
				},
			},
			pickers = {
				keymaps = {
					layout_config = size_keymaps,
				},
				current_buffer_fuzzy_find = {
					previewer = false,
					layout_config = size_fuzzy_find,
				},
			},
		}
	end,
}
