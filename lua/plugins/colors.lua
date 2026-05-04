vim.pack.add({
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/catgoose/nvim-colorizer.lua",
})

require("tokyonight").setup({
  style = "night",
  transparent = true,
  styles = {
    comments = { italic = false },
  },
})

vim.cmd("colorscheme tokyonight-night")

require("colorizer").setup()
