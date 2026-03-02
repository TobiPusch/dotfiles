return {
  -- Mason zum Verwalten von LSP-Servern, Lintern und Formattern
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Brücke zwischen Mason und lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "rust_analyzer" },
      })
    end,
  },

  -- Die eigentlichen LSP-Konfigurationen (JETZT AKTUALISIERT)
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      -- Wir benutzen kein local lspconfig = require("lspconfig") mehr!

      -- C/C++ Setup mit der neuen nativen API
      vim.lsp.config('clangd', {
        cmd = { "clangd" },
        filetypes = { "c", "cpp", "objc", "objcpp" },
      })
      vim.lsp.enable('clangd')

      -- Rust Setup
      vim.lsp.config('rust_analyzer', {})
      vim.lsp.enable('rust_analyzer')
    end,
  },
}
