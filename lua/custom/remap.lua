vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

local function goto_next()
	vim.diagnostic.jump({ count = 1, float = true })
end

local function goto_prev()
	vim.diagnostic.jump({ count = -1, float = true })
end

-- General
vim.keymap.set("n", "<leader><leader>", ":source %<CR>", { desc = "Source current file" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Explorer is 'e'
vim.keymap.set({ "n", "v" }, "<leader>ee", ":Yazi<CR>", { desc = "Open yazi at the current file" })
vim.keymap.set("n", "<leader>ew", ":Yazi cwd<CR>", { desc = "Open the file manager in nvim's working directory" })
vim.keymap.set("n", "<leader>et", ":Yazi toggle<CR>", { desc = "Resume the last yazi session" })

-- Go to is 'g'
vim.keymap.set("n", "<leader>gp", goto_prev, { desc = "Jump to the previous diagnostic" })
vim.keymap.set("n", "<leader>gn", goto_next, { desc = "Jump to the next diagnostic" })

-- Diagnostics is 'q'
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Search is 's' (see plugins/telescope.lua)

-- Window is 'w'
vim.keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })

-- Diagnostics is 'x' (see plugins/trouble.lua)

-- Navigation
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
