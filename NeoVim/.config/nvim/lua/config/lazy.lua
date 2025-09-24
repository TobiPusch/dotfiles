
--[[
==============================
        USAGE GUIDE
==============================

-- Additional programs
- clangd : show variable definition
- bear   : create compile_commands.json for global definition explanation

-- LSP / lspsaga Shortcuts
K  -> Hover-Popup (Info zu Variable, Funktion, Struct)
gd -> Gehe zur Definition
gr -> Zeige Referenzen (nur Standard LSP)
gi -> Gehe zur Implementierung (nur Standard LSP)

-- Markdown
Öffne .md Dateien -> Renderer aktiv automatisch

-- Plugins automatisch aktiv
- nvim-treesitter -> Syntax Highlighting & Code Struktur
- nvim-web-devicons -> Icons für lspsaga & Markdown
- mini.nvim -> für Markdown Renderer

-- Plugin Management
:Lazy update             -> Alle Plugins aktualisieren
:Lazy install <plugin>   -> Einzelnes Plugin installieren

-- Hinweise für C/C++
- clangd muss Include-Pfade kennen (z.B. /usr/include)
- Für CMake-Projekte: cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .
- Für Makefile-Projekte: bear -- make → erzeugt compile_commands.json für LSP
- Dateien: .c, .h, .cpp, .hpp → LSP und Hover aktiv
]]



-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
{"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"},
-- LSP für C/C++
{
  "neovim/nvim-lspconfig",
  lazy = false,
  config = function()
    local lspconfig = require("lspconfig")
    lspconfig.clangd.setup{
      cmd = { "clangd", "--background-index" }, -- Background Indexing für schnelle Suche
      on_attach = function(client, bufnr)
        local opts = { noremap=true, silent=true, buffer=bufnr }

        -- Hover
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        -- Definition springen
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        -- Referenzen anzeigen
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        -- Implementation
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      end
    }
  end
},
{
  "glepnir/lspsaga.nvim",
  branch = "main",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional für Icons
  config = function()
    require("lspsaga").setup({})
    -- Keymaps
    local opts = { noremap=true, silent=true }
    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
    vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)
  end
},
{
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
}

  --  { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = {
    enabled = true,      -- automatische Updates weiterhin aktiv
    notify = false,      -- **keine Meldung beim Start**
  },
})
