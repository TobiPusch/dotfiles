return {
 "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        integrations = { treesitter = true }
      })
    end,

}
