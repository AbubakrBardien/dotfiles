require "nvchad.options"

-- add yours here!

local opt = vim.opt

opt.cursorlineopt = "both" -- to enable cursorline!
opt.cursorcolumn = true
opt.relativenumber = true
opt.guicursor = ""

vim.api.nvim_command "highlight CursorColumn guibg=#252931"

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = false

opt.scrolloff = 8

vim.cmd("set wildmenu")
vim.cmd("set wildmode=longest:full,full")

-- If no filename provided, open the dashboard
if vim.fn.argc() == 0 then
    vim.cmd("Nvdash")
end
