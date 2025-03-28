-- load lazy
require("config.lazy")
-- terminal scripts
require("custom.term")

-- teej remaps
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")
vim.keymap.set("n", "<leader>xt", ":PlenaryBustedFile %<CR>")
-- clipboard yank
vim.keymap.set("v", "Y", "\"+y")

-- set options
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "no"
-- conceal level for obsidian.nvim
vim.opt.conceallevel = 2



