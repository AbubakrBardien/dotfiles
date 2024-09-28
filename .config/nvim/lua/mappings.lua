require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

-- add yours here

map("n", "<C-a>", "gg0vG$", { desc = "Highlight Entire Window" })
