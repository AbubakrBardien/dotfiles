vim.g.mapleader = " "

local colorscheme = "onedark"

require("options")

--- Install Lazy.nvim if not already installed ---
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
	--- Loading plugins ---
	spec = { import = "plugins" },

	--- Lazy.nvim config ---
	install = { colorscheme = { colorscheme } },
	change_detection = { notify = false },
	checker = {
		enabled = true,
		notify = false,
		frequency = 86400, -- Check daily (every 86400 seconds)
	},
}

vim.api.nvim_command("colorscheme " .. colorscheme)

--- Color related configs ---
require("highlights")
require("colorizer").setup { "*", "!lazy" } -- Don't apply 'colorizer' to the Lazy menu

--- Keymaps ---
require("keymaps")
