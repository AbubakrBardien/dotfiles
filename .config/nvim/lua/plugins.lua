local common_deps = require("dependency_list")

return {
	{
		-- Favourite Theme
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
		config = function()
			require("onedarkpro").setup {
				options = { cursorline = true },
			}
		end,
	},

	require("plugin_configs.telescope"),

	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
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
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup {
				auto_install = true,
				highlight = { enable = true },
			}
		end,
	},
	{
		-- File Tree
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		dependencies = { common_deps["nvim_web_devicons"] },
		config = function()
			require("plugin_configs.file_tree")
		end,
	},

	{ "ThePrimeagen/vim-be-good" },

	{
		-- Statusline
		"nvim-lualine/lualine.nvim",
		dependencies = { common_deps["nvim_web_devicons"] },
		config = function()
			require("plugin_configs.statusline.lualine")
		end,
	},

	require("plugin_configs.mason.mason"),

	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("plugin_configs.dashboard")
		end,
		dependencies = { common_deps["nvim_web_devicons"] },
	},

	require("plugin_configs.auto-completions"),
	require("plugin_configs.git_integration"),

	{
		"norcalli/nvim-colorizer.lua",
		event = { "BufWritePost" }, -- execute on save
	},
	{
		"windwp/nvim-autopairs", -- auto-close brackets
		event = "InsertEnter",
		config = true,
	},
	{ "voldikss/vim-floaterm" },
}
