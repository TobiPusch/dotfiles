return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter", -- Lädt das Plugin erst, wenn du in den Insert-Modus gehst
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",     -- LSP-Vorschläge
        "L3MON4D3/LuaSnip",         -- Snippet-Engine (Zwingend erforderlich für clangd!)
        "saadparwaiz1/cmp_luasnip", -- Verbindet LuaSnip mit nvim-cmp
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            -- Snippet-Engine konfigurieren (Das hat bei dir vorher das printf blockiert)
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            -- Tastenbelegungen
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(), -- Vorschläge manuell öffnen
                ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Mit Enter bestätigen
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            -- Woher sollen die Vorschläge kommen?
            sources = cmp.config.sources({
                { name = "nvim_lsp" }, -- Von clangd/rust_analyzer
                { name = "luasnip" },  -- Von deinen Snippets
            })
        })
    end,
}
