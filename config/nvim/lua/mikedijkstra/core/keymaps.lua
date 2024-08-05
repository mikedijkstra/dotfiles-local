vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", ";", ":", { desc = "CMD enter command mode" })
--keymap.set("i", "jk", "<ESC>")

keymap.set("n", "J", ":bprev <cr>")
keymap.set("n", "K", ":bnext <cr>")
keymap.set("n", "W", ":bd <cr>")
keymap.set("n", "Q", ":bd! <cr>")

keymap.set("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>")
keymap.set("n", "<leader>dr", "<cmd> DapContinue <CR>")

local opts = { noremap = true, silent = true }
keymap.set("n", "<C-j>", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
keymap.set("n", "<C-d>", "<Cmd>Lspsaga hover_doc<CR>", opts)
keymap.set("n", "<C-r>", "<Cmd>Lspsaga code_action<CR>", opts)
keymap.set("n", "<C-g>", "<Cmd>Lspsaga show_line_diagnostics<CR>", opts)
keymap.set("i", "<C-k>", "<Cmd>Lspsaga signature_help<CR>", opts)
keymap.set("n", "gp", "<Cmd>Lspsaga preview_definition<CR>", opts)
keymap.set("n", "gd", vim.lsp.buf.definition, opts)
keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
keymap.set("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
keymap.set("n", "<c-p>", ":Telescope find_files hidden=true<cr>", opts)
keymap.set("n", "<c-f>", ":Telescope live_grep hidden=true<cr>", opts)
keymap.set("n", "<c-o>", ":Telescope file_browser hidden=true<cr>", opts)
keymap.set("n", "<leader><leader>", ":NvimTreeFindFile <cr>", opts)
