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
keymap.set("n", "<leader>jj", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
keymap.set("n", "<leader>jk", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
keymap.set("n", "<C-d>", "<Cmd>Lspsaga hover_doc<CR>", opts)
keymap.set("n", "<C-r>", "<Cmd>Lspsaga code_action<CR>", opts)
keymap.set("n", "<C-g>", "<Cmd>Lspsaga show_line_diagnostics<CR>", opts)
keymap.set("i", "<leader>jh", "<Cmd>Lspsaga signature_help<CR>", opts)
keymap.set("n", "<leader>jn", "<Cmd>Lspsaga preview_definition<CR>", opts)
keymap.set("n", "gd", vim.lsp.buf.definition, opts)
keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
keymap.set("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
keymap.set("n", "<c-p>", ":Telescope find_files hidden=true<cr>", opts)
keymap.set("n", "<c-f>", ":Telescope live_grep hidden=true<cr>", opts)

keymap.set("n", "<leader>os", ":ObsidianSearch<cr>", opts)
keymap.set("n", "<leader>ot", ":ObsidianToday<cr>", opts)
keymap.set("n", "<leader>oi", ":ObsidianYesterday<cr>", opts)
keymap.set("n", "<leader>of", ":ObsidianFollowLink<cr>", opts)
keymap.set("n", "<leader>on", ":ObsidianNewFromTemplate<cr>", opts)
keymap.set("n", "<leader>om", ":ObsidianRename<cr>", opts)

keymap.set("n", "<leader>hc", ":Git commit<cr>", opts)
keymap.set("n", "<leader>hb", ":Git blame<cr>", opts)

vim.api.nvim_create_user_command("StopTS", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local current_dir = vim.fn.expand("%:p:h")

	-- Stop the TypeScript LSP for the current buffer only
	for _, client in pairs(vim.lsp.get_active_clients()) do
		if client.name == "tsserver" then
			vim.lsp.buf_detach_client(bufnr, client.id)
		end
	end

	local nvim_lsp = require("lspconfig")
	nvim_lsp.denols.setup({
		root_dir = function(fname)
			return current_dir
		end,
	})
end, {})
keymap.set("n", "<leader>df", ":StopTS<cr>", opts)

vim.api.nvim_create_user_command("InlayHintToggle", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, {})

vim.keymap.set("n", "<leader>ni", ":InlayHintToggle<CR>", opts)
vim.keymap.set("n", "<leader>l", ":AvanteAsk<CR>", opts)

--vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
--vim.keymap.set({ "n", "v" }, "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
--vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
-- vim.cmd([[cab cc CodeCompanion]])
