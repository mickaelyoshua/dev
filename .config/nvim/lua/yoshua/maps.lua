vim.g.mapleader = " "

local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { silent = true })
end

map("n", "<leader>fs", vim.cmd.Ex)

-- Telescope
local builtin = require("telescope.builtin")
map("n", "<leader>ff", builtin.find_files) -- Search all
map("n", "<leader>fp", builtin.live_grep) -- Search with grep
map("n", "<leader>fg", builtin.git_files) -- Search files in git

-- Harpoon
local harpoon = require("harpoon")
harpoon:setup()
map("n", "<leader>a", function() harpoon:list():add() end )
map("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end )
