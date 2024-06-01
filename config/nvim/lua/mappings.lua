require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "J", ":bprev <cr>")
map("n", "K", ":bnext <cr>")
map("n", "W", ":bd <cr>")
map("n", "Q", ":bd! <cr>")

map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>")
map("n", "<leader>dr", "<cmd> DapContinue <CR>")

local opts = { noremap = true, silent = true }
map("n", "<C-j>", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
map("n", "<C-d>", "<Cmd>Lspsaga hover_doc<CR>", opts)
map("n", "<C-f>", "<Cmd>Lspsaga code_action<CR>", opts)
map("n", "<C-g>", "<Cmd>Lspsaga show_line_diagnostics<CR>", opts)
map("i", "<C-k>", "<Cmd>Lspsaga signature_help<CR>", opts)
map("n", "gp", "<Cmd>Lspsaga preview_definition<CR>", opts)
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "<space>D", vim.lsp.buf.type_definition, opts)
map("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
map("n", "<c-p>", ":Telescope find_files hidden=true<cr>")
map("n", "<c-i>", ":Telescope live_grep hidden=true<cr>")
map("n", "<c-o>", ":Telescope file_browser hidden=true<cr>")
map("n", "<leader><leader>", ":NvimTreeFindFile <cr>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
