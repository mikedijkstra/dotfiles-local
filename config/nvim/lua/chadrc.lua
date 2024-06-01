-- This file  needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
	theme = "nightowl",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}


require('nvim-tree').setup({
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
})

vim.opt.swapfile = false

return M
