-- Add Lua modules directory to runtime path
local config_path = vim.fn.stdpath("config")
package.path = package.path .. ";" .. config_path .. "/lua/?.lua;" .. config_path .. "/lua/?/init.lua"

-- Your Lazy.nvim setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "mikedijkstra.plugins" },
	{ import = "mikedijkstra.plugins.lsp" },
}, {
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})
print("Lazy.nvim configuration loaded")
