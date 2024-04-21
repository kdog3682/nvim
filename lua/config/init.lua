local lockfilepath = vim.fn.stdpath("config") .. "/lazy-lock.json" -- lockfile generated after running update.
local lazyrootpath = vim.fn.stdpath("data") .. "/lazy" -- directory where plugins will be installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.opt.termguicolors = true -- enable 24-bit RGB colors

require("lazy").setup({
	root = lazyrootpath,
	spec = {
		import = "plugins",
	},
	lockfile = lockfilepath,
	defaults = {
		lazy = false, -- should plugins be lazy-loaded?
		version = nil,
		-- version = "*", -- latest stable
	},
	install = {
		-- install missing plugins on startup
		-- colorscheme = {"rose-pine", "habamax"}
		missing = true,
	},
	checker = {
		-- automatically check for plugin updates
		-- enabled = true,
		enabled = false,
		-- get a notification when new updates are found
		-- disable it as it's too annoying
		notify = false,
		-- check for updates every day
		frequency = 86400,
	},
	change_detection = {
		-- automatically check for config file changes and reload the ui
		enabled = aflse,
		-- get a notification when changes are found
		-- disable it as it's too annoying
		notify = false,
	},
	performance = {
		cache = {
			enabled = true,
		},
	},
	state = vim.fn.stdpath("state") .. "/lazy/state.json", -- state info for checker and other things
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

local modules = {
	"config.options",
	"config.autocmds",
	-- "snippets.lua",
    -- "config.more.lua",
    -- "config.more.snippets",
    -- "config.snippets.lua",
    -- "config.snippets.test",
    -- "config.more.lua",
    -- "config.keymaps",
    -- "config.more.keymaps",
}

for _, mod in ipairs(modules) do
	local ok, err = pcall(require, mod)
	if not ok then
		error(("Error loading %s...\n\n%s"):format(mod, err))
	end
end

local M = require("stdlib.meta")
M.remove_bracket_mappings()

local languages = {
    "lua",
    "typst",
    "vue",
    "javascript",
    "typescript",
}

