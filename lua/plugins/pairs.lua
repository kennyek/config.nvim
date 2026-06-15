vim.pack.add({
	{
		src = "https://github.com/nvim-mini/mini.pairs",
		version = "main",
	},
})

local pairs = require("mini.pairs")

pairs.setup()
