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

require("nvim-tree").setup {
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
}

vim.opt.swapfile = false

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  group = vim.api.nvim_create_augroup("Color", {}),
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "MatchParen", { guibg = "#011627" })
  end,
})

return M
