return {
    {
	dir = "~/programming/nvim-plugins/present.nvim",
	config = function()
	    require("present").setup({
		executors = {
		    python = "python",
		    javascript = "node",
		    lua = "luajit",
		}
	    })
	end,
    }
}
