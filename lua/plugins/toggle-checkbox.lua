return {
    {
	"opdavies/toggle-checkbox.nvim",
	config = function()
	    vim.keymap.set("n", "<leader>x", ":lua require('toggle-checkbox').toggle()<CR>")
	end
    }
}
