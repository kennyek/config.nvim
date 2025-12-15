local M = {}

M.setup = function()
	require("nvim-treesitter").install({
		"bash",
		"css",
		"csv",
		"dockerfile",
		"fish",
		"gitignore",
		"go",
		"gomod",
		"gosum",
		"groovy",
		"html",
		"javascript",
		"jsdoc",
		"json",
		"json5",
		"jsx",
		"lua",
		"luadoc",
		"make",
		"markdown",
		"nginx",
		"regex",
		"ssh_config",
		"tsx",
		"typescript",
		"xml",
		"yaml",
		"zsh",
	})
end

return M
