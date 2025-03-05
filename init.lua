-- load lazy
require("config.lazy")
-- terminal scripts
require("custom.term")

-- teej remaps
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

-- set options
vim.opt.shiftwidth = 4
vim.opt.number = true
-- conceal level for obsidian.nvim
vim.opt.conceallevel = 2
