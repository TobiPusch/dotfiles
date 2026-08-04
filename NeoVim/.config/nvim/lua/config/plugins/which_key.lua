return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        -- Deine Einstellungen hier (oder einfach leer lassen für die tolle Standard-Ansicht)
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
