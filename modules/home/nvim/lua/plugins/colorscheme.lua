return {
  {
    "folke/tokyonight.nvim",
    lazy = false, -- Load immediately
    priority = 1000, -- Load before other plugins
    opts = {
      style = "night", -- Tokyo Night Dark theme
      transparent = true, -- Enable transparency
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight") -- Set the colorscheme
    end,
  },
}
