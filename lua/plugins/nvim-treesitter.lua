function config()
	require("nvim-treesitter.configs").setup({
		ensure_installed = { "lua", "vim", "typst", "javascript", "vue", "typescript" },
		sync_install = false,
		auto_install = false,
		ignore_install = {},
		highlight = {
			enable = false,
			disable = function(lang, buf)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
			additional_vim_regex_highlighting = false,
		},
	})
end

return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {},
	config = config,
}
