local g = vim.g
local opt = vim.opt

g.mapleader = " "

---- Line Numbering ----
opt.relativenumber = true
opt.number = true
opt.numberwidth = 2

---- Cursor Highlighting --
opt.cursorline = true
opt.cursorcolumn = true

---- Indenting ----
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

---- Spell-check ----
opt.spell = false -- toggle when needed
opt.spelllang = { "en_gb" }

---- Code Folding ----
vim.o.foldcolumn = "0"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

---- Other Options ----
opt.guicursor = ""            -- To make the cursor stay the same when in insert mode
opt.clipboard = "unnamedplus" -- Makes vim use the system clipboard
opt.scrolloff = 8
opt.showmode = false
opt.signcolumn = "yes:1"

---- Plugin Options ----
g.floaterm_width = 0.9
g.floaterm_height = 0.9
