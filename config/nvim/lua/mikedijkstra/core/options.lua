vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tab & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

-- theming
opt.termguicolors = true
--opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

-- Set for obsidian
opt.conceallevel = 1

local group = vim.api.nvim_create_augroup("Markdown Wrap Settings", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.md" },
	group = group,
	command = "setlocal wrap",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		-- Enable soft wrapping
		vim.opt_local.textwidth = 120
	end,
})

-- highlight codefences returned from denols
vim.g.markdown_fenced_languages = {
	"ts=typescript",
}

vim.filetype.add({
	pattern = {
		[".*%.blade%.php"] = "blade",
	},
})

-- Recommended by avante
vim.opt.laststatus = 3
