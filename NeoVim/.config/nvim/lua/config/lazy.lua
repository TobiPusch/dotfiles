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
-- vim.g.maplocalleader = "\\"

-- Keymaps
-- Zeigt die Fehlermeldung unter dem Cursor an
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostic error" })

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ "folke/tokyonight.nvim" },
		{ "morhetz/gruvbox" },

		{ import = "config.plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	-- automatically check for plugin updates
	checker = {
		enabled = true, -- automatische Updates weiterhin aktiv
		notify = false, -- **keine Meldung beim Start**
	},
})

vim.api.nvim_create_user_command("Format", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "Formatiert den aktuellen Buffer via LSP" })
