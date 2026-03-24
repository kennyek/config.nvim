vim.pack.add({
	"https://github.com/NickvanDyke/opencode.nvim",
})

vim.g.opencode_opts = {}

-- Required for `opts.events.reload`.
vim.o.autoread = true

vim.keymap.set({ "n", "x" }, "<leader>oa", function()
	require("opencode").ask("@this: ", { submit = true })
end, { desc = "[O]pencode: [A]sk" })
vim.keymap.set({ "n", "x" }, "<leader>ox", function()
	require("opencode").select()
end, { desc = "[O]pencode: E[x]ecute action" })
vim.keymap.set({ "n", "t" }, "<leader>ot", function()
	require("opencode").toggle()
end, { desc = "[O]pencode: [T]oggle" })

vim.keymap.set({ "n", "x" }, "go", function()
	return require("opencode").operator("@this ")
end, { desc = "Add range to opencode", expr = true })
vim.keymap.set("n", "goo", function()
	return require("opencode").operator("@this ") .. "_"
end, { desc = "Add line to opencode", expr = true })

vim.keymap.set("n", "<S-C-u>", function()
	require("opencode").command("session.half.page.up")
end, { desc = "Scroll opencode up" })
vim.keymap.set("n", "<S-C-d>", function()
	require("opencode").command("session.half.page.down")
end, { desc = "Scroll opencode down" })
