return {
    {
	"epwalsh/obsidian.nvim",
	config = function()
	    -- setup
	    require("obsidian").setup {
		    workspaces = {
		    {
		    name = "zettelkasten",
			path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/zettelkasten",
		    }
		},
		completion = {
		    nvim_cmp = true,
		    min_chars = 2,
		},
		notes_subdir = "inbox",
		new_notes_location = "notes_subdir",
		daily_notes = {
		    folder = "journal",
		    date_format = "%Y-%m-%d",
		},
		mappings = {
		    ["gf"] = {
			action = function()
			    return require("obsidian").util.gf_passthrough()
			end,
			opts = { noremap = false, expr = true, buffer = true },
		    },
		},
		attachments = {
		    img_folder = "attachments"
		},
	    }
	end
    }
}
