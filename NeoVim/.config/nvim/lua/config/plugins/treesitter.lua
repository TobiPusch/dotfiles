return {
  {
  "nvim-treesitter/nvim-treesitter",  build = ":TSUpdate",
config = function() 
	require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "java" },
  	auto_install = true,
  -- List of parsers to ignore installing (or "all")
  	ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

highlight = {
    enable = true,
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true  -- Datei zu groß → disable
        end
        return false  -- Wichtig! Datei klein genug → enable
    end,
    additional_vim_regex_highlighting = false,
},
}
end,


	}

}
