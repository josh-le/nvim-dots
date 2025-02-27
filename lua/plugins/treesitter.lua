return {
    {
	"nvim-treesitter/nvim-treesitter",
	config = function()
	    vim.cmd("TSUpdate")
	    require'nvim-treesitter.configs'.setup {

		ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

		auto_install = true,

		highlight = {
		    enable = true,
		},
	    }
	end,
    }
}
