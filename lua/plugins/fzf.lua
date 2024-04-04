return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local setup = {
			winopts = {
				height = 0.65,
				preview = {
					hidden = "hidden",
				},
				files = {
					prompt = "",
					color_icons = false,
				},
			},
		}
		local setup = "fzf-native"
		require("fzf-lua").setup(setup)
	end,
}
