local common_deps = require("dependency_list")

return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	dependencies = { common_deps["mini_icons"] },
	config = function()
		require("nvim-tree").setup {
			view = {
				width = {
					min = 35,
					padding = 1,
				},
				-- side = "right",
				relativenumber = true,
			},
			filters = { dotfiles = false },
			hijack_cursor = true,
			disable_netrw = true,
			update_focused_file = {
				enable = true,
				update_root = false,
			},
			renderer = {
				group_empty = true,
				full_name = true,
				indent_width = 4,
				indent_markers = { enable = true },
				icons = {
					show = { folder_arrow = false },
					glyphs = { git = { unmerged = "" } },
				},
				root_folder_label = ":t/",
			},
		}
	end,
}
