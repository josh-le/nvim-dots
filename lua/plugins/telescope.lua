return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
	require("telescope").setup({
	    pickers = {
		find_files = {
		    -- theme = "ivy"
		}
	    },
		--    extensions = {
		-- fzf = {}
		--    }
	})

	-- require("telescope").load_extension('fzf')

	local builtin = require('telescope.builtin')

	vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
	vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
	vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
	vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
	vim.keymap.set('n', '<leader>fc', function()
	    require('telescope.builtin').find_files {
		cwd = vim.fn.stdpath("config")
	    }
	end)
	vim.keymap.set('n', '<leader>fzf', function()
	    require('telescope.builtin').find_files {
		cwd = "/Users/joshleblanc/Library/Mobile Documents/iCloud~md~obsidian/Documents/zettelkasten"
	    }
	end)
	vim.keymap.set('n', '<leader>fzg', function()
	    require('telescope.builtin').live_grep {
		cwd = "/Users/joshleblanc/Library/Mobile Documents/iCloud~md~obsidian/Documents/zettelkasten"
	    }
	end)
    end
}
