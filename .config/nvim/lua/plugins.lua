local common_deps = require("dependency_list")

return {
	{
		-- Favourite Theme
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
		config = function()
			require("onedarkpro").setup {
				colors = { onedark = { bg = "#1d1f24" } },
			}
		end,
	},

	---@diagnostic disable-next-line: different-requires
	require("plugin_configs.fuzzy_finder.telescope"),

	{
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

	require("plugin_configs.lsp_signatures"),

	require("plugin_configs.git_signs"),

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

	{
		"toppair/peek.nvim",
		event = { "VeryLazy" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup {
				app = { "firefox", "--new-window" },
			}
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},
}
