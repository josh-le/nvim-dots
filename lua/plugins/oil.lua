return {
    {
	'stevearc/oil.nvim',
	opts = {},
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	lazy = false,
	config = function()
	    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	    require("oil").setup({
		view_options = {
		    show_hidden = true
		},
		skip_confirm_for_simple_edits = true,
	    })
	end
    }
}
