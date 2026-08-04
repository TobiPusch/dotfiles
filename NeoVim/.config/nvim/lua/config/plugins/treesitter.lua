return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = { 
          "c", 
          "lua", 
          "vim", 
          "vimdoc", 
          "query", 
          "markdown", 
          "markdown_inline", 
          "java", 
          "html" 
        },
        auto_install = true,
      })
    end,
  },
}
