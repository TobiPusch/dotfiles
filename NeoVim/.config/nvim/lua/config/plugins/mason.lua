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

	-- Die eigentlichen LSP-Konfigurationen
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp", -- Wichtig für die Autocomplete-Fähigkeiten
		},
		config = function()
			-- Lade die Fähigkeiten deines Autocomplete-Plugins
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- C/C++ Setup mit der NEUEN nativen API
			vim.lsp.config("clangd", {
				cmd = {
					"clangd",
					"--background-index",
					"--header-insertion=never",
					"--query-driver=/usr/bin/gcc,/usr/bin/g++", -- Fix für Arch Linux

					-- NEUE FLAGS FÜR MEHR GESCHWINDIGKEIT:
					"-j=4",    -- Nutzt 4 CPU-Kerne gleichzeitig (falls du einen starken PC hast, mach "8" draus)
					"--pch-storage=memory", -- Hält den Zwischenspeicher (Precompiled Headers) im RAM statt auf der Festplatte (sehr viel schneller!)
					"--completion-style=detailed", -- Verbessert die Lesbarkeit der Vorschläge
				},
				filetypes = { "c", "cpp", "objc", "objcpp" },
				capabilities = capabilities, -- <-- HIER sagen wir clangd, dass wir Snippets unterstützen!
			})
			vim.lsp.enable("clangd")

			-- Rust Setup
			vim.lsp.config("rust_analyzer", {
				capabilities = capabilities, -- Auch hier direkt mit übergeben
			})
			vim.lsp.enable("rust_analyzer")
		end,
	},
}
