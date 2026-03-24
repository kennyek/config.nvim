vim.pack.add({
	"https://github.com/folke/tokyonight.nvim",
})

require("tokyonight").setup({
	style = "night",
	transparent = true,
	styles = {
		comments = { italic = false },
	},
})

vim.cmd("colorscheme tokyonight-night")
