default_sources = {
	-- Order Matters! It sets the priority in the Completion Menu
	{
		name = "nvim_lsp",

		-- Filters out "Text" completions based on text in current buffer
		-- Also filters "Snippet" completions, becuase "luasnip" handles that better

		---@diagnostic disable-next-line: unused-local
		entry_filter = function(entry, ctx)
			local current_entry = require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]
			return current_entry ~= "Text" and current_entry ~= "Snippet"
		end,
	},
	{ name = "hrsh7th/cmp-nvim-lsp" },
	{ name = "nvim_lua" },
	{ name = "fish" },
	{ name = "path" },
	{ name = "luasnip" },
}

local function custom_sources(tbl)
	local output_tbl = {}
	for _, source in ipairs(default_sources) do
		output_tbl[#output_tbl + 1] = source
	end
	for _, source in ipairs(tbl) do
		output_tbl[#output_tbl + 1] = source
	end
	return output_tbl
end

------------------------------

return {
	{
		-- Only displays the window to list the completions, that's all.
		-- The options in the widow could be snippets from a Snippet Engine, or language-specific features from an LSP.
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			local lspKind = require("lspkind")

			require("luasnip.loaders.from_vscode").lazy_load {
				exclude = { "lua", "python", "all" },
			}

			cmp.setup {
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},

				sources = default_sources,

				formatting = {
					fields = {
						cmp.ItemField.Kind,
						cmp.ItemField.Abbr,
						cmp.ItemField.Menu,
					},
					format = lspKind.cmp_format {
						mode = "symbol",
						maxwidth = 20,
						ellipsis_char = "...",
						menu = {
							nvim_lsp = "[LSP]",
							nvim_lua = "[API]",
							fish = "[fish]",
							path = "[path]",
							dotenv = "[ENV]",
							luasnip = "[luasnip]",
							buffer = "[buffer]",
						},
					},
				},
			}

			--- Filetype Specific Sources ---
			cmp.setup.filetype({ "markdown", "text" }, {
				sources = custom_sources({
					{ name = "buffer", keyword_length = 5 },
				}),
			})
			cmp.setup.filetype({ "sh", "fish" }, {
				sources = custom_sources({
					{ name = "dotenv", keyword_length = 5 },
				}),
			})

			-- Automatically puts brackets in front of the selected function/method
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources { { name = "cmdline", keyword_length = 6 } },
				formatting = { fields = { cmp.ItemField.Abbr } },
			})
		end,
	},

	------ Sources Plugins ------

	{
		"L3MON4D3/LuaSnip", -- Snippet Engine for Neovim
		dependencies = {
			"saadparwaiz1/cmp_luasnip", -- LuaSnip completion source for nvim-cmp
			"rafamadriz/friendly-snippets", -- All-in-one repo for snippets (community driven)
		},
		config = function()
			local luasnip = require("luasnip")
			luasnip.config.set_config {
				updateevents = "TextChanged,TextChangedI", -- When using dynamic snippets, this makes it update as you type.
			}
		end,
	},

	{ "hrsh7th/cmp-nvim-lsp" }, -- provides completions for the LSP attached to the buffer
	{ "hrsh7th/cmp-path" }, -- file path
	{ "hrsh7th/cmp-nvim-lua" }, -- provides completions for Neovim's Lua runtime API
	{ "mtoohey31/cmp-fish" }, -- shell
	{ "SergioRibera/cmp-dotenv" }, -- environment variables
	{ "hrsh7th/cmp-buffer" }, -- suggests words in current buffer
	{ "hrsh7th/cmp-cmdline" },

	------ Other related plugin(s) ------

	{ "onsails/lspkind.nvim" }, -- For adding icons to Compleion Menu
}
