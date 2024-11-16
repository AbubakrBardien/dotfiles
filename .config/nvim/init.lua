vim.g.mapleader = " "

require("options")

--- Install Lazy.nvim if not already installed ---
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

--- Load Lazy.nvim and the plugins ---
require("lazy").setup("plugins")

--- Color related configs ---
require("highlights")
require("colorizer").setup()

--- Keymaps ---
require("keymaps")
