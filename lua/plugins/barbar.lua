return {
    {
	"romgrk/barbar.nvim",
	dependencies = {
	    "nvim-tree/nvim-web-devicons"
	},
	config = function()
	    require'barbar'.setup()

	    -- remaps
	    vim.keymap.set("n", "<leader>bd", "<cmd>BufferClose<CR>")
	    -- forward/back
	    vim.keymap.set("n", "H", "<cmd>BufferPrevious<CR>")
	    vim.keymap.set("n", "L", "<cmd>BufferNext<CR>")
	    -- goto buffer
	end
    }
}
