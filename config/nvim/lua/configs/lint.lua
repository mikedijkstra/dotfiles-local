require("lint").linters_by_ft = {
	javascript = { "eslint" },
	typescript = { "eslint" },
	vue = { "eslint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged", "InsertLeave" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
