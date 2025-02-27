-- pretty up when we open terminal
vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('term-open', { clear = true }),
    callback = function()
	vim.opt.number = false
	vim.opt.relativenumber = false
    end
})

-- remaps
vim.keymap.set("n", "<leader>tt", "<cmd>term<CR>")
vim.keymap.set("t", "qw", "<C-\\><C-n>")
vim.keymap.set("t", "qq", "<C-\\><C-n>:bd!<CR>")

-- small terminal
vim.keymap.set("n", "<leader>ts", function()
    local handle = vim.api.nvim_get_current_win()
    local height = math.max(5, math.floor(vim.api.nvim_win_get_height(handle) / 4))
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, height)
end)


