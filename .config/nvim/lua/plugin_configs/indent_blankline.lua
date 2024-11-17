return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	---@module "ibl"
	---@diagnostic disable-next-line: undefined-doc-name
	---@type ibl.config
	opts = {
		exclude = { filetypes = { "dashboard" } },
		indent = {
			char = "▏",
			priority = 1,
		},
		whitespace = { highlight = { "Whitespace" } },
	},
}
