return {
    {
	"Josh-LeBlanc/present.nvim",
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
