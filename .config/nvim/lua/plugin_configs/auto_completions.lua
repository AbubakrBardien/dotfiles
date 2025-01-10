local common_deps = require("dependency_list")

return {
	{
		"saghen/blink.compat",
		version = "*",
		opts = {},
	},
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"mtoohey31/cmp-fish",
			"bydlw98/cmp-env",
			common_deps["mini_icons"],
		},
		version = "*",
		-- Disable for some filetypes

		-- enabled = function()
		-- 	return vim.bo.filetype ~= "DressingInput"
		-- end,

		-- enabled = function()
		-- 	return not vim.tbl_contains({ "lua", "markdown" }, vim.bo.filetype) and vim.bo.buftype ~= "prompt" and
		-- 	vim.b.completion ~= false
		-- end,

		enabled = function()
			local disabled_filetypes = { "lua", "DressingInput" }
			return not vim.tbl_contains(disabled_filetypes, vim.bo.filetype)
		end,

		opts = {
			keymap = {
				preset = "enter",
				["<C-space>"] = { "show", "hide", "fallback" },
				["<S-Left>"] = { "scroll_documentation_up", "fallback" },
				["<S-Right>"] = { "scroll_documentation_down", "fallback" },

				["<C-e>"] = {},
				["<C-p>"] = {},
				["<C-n>"] = {},
			},

			appearance = {
				use_nvim_cmp_as_default = true, -- will be removed in future update
				nerd_font_variant = "mono",
			},

			sources = {
				default = function()
					if vim.bo.filetype == "text" then
						return { "buffer", "path" }
					elseif vim.bo.filetype == "markdown" then
						return { "buffer", "path", "snippets", "env" }
					else
						return { "path", "snippets", "env", "lsp", "fish" }
					end
				end,

				cmdline = {},

				providers = {
					buffer = {
						min_keyword_length = 5,
					},
					fish = {
						name = "fish",
						module = "blink.compat.source",
					},
					env = {
						name = "env",
						module = "blink.compat.source",
						min_keyword_length = 5,
					},
				},
			},

			signature = { enabled = true },

			completion = {
				menu = {
					scrollbar = false,
					draw = {
						columns = { { "kind_icon", "label", "source_name", gap = 1 } },
						-- columns = { { "label", gap = 1 } },
						-- columns = function()
						-- 	if vim.bo.filetype == "text" then
						-- 		return { { "label", gap = 1 } }
						-- 	else
						-- 		return { { "kind_icon", "label", "source_name", gap = 1 } }
						-- 	end
						-- end,
						components = {
							-- Makes "Blink.cmp" use icons from "Mini.icons"
							kind_icon = {
								ellipsis = false,
								text = function(ctx)
									local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
									return kind_icon
								end,
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},

							label = { width = { fill = true, max = 50 } },
						},
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 500,
				},
			},
		},
	},
}

-- Check their website to learn more about the default settings
