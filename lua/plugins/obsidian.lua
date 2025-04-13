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

	    -- keymaps

	    -- school note
	    vim.api.nvim_create_user_command("NSN", function()
		 -- Get the current mode
		local mode = vim.fn.mode()

		-- Check if we're in visual mode
		if mode == 'v' or mode == 'V' or mode == '' then
		    -- Save the current register content
		    local old_reg = vim.fn.getreg('"')
		    local old_regtype = vim.fn.getregtype('"')

		    -- Yank the selected text to the unnamed register
		    vim.cmd('y')

		    -- Get the yanked text
		    local selected_text = vim.fn.getreg('"')

		    -- get class
		    local class = selected_text:match("%d%d%d%d%d")
		    if class == nil then
			print("could not match class number")
			return
		    end

		    -- get full note title
		    local title = selected_text:sub(3, -4) .. ".md"

		    local path = "school/spring2025/" .. class .. "/" .. title

		    -- open file and write it
		    vim.cmd('e ' .. path)
		    vim.cmd('w')

		    -- Restore the register
		    vim.fn.setreg('"', old_reg, old_regtype)
		else
		    print("Not in visual mode")
		end
	    end, {})
	    vim.keymap.set("n", "<leader>zs", "vi[<cmd>NSN<CR>")

	    -- regular note
	    vim.api.nvim_create_user_command("NZK", function()
		 -- Get the current mode
		local mode = vim.fn.mode()

		-- Check if we're in visual mode
		if mode == 'v' or mode == 'V' or mode == '' then
		    -- Save the current register content
		    local old_reg = vim.fn.getreg('"')
		    local old_regtype = vim.fn.getregtype('"')

		    -- Yank the selected text to the unnamed register
		    vim.cmd('y')

		    -- Get the yanked text
		    local selected_text = vim.fn.getreg('"')

		    -- get full note title
		    local title = selected_text:sub(3, -4) .. ".md"

		    local path = "zettelkasten/" .. title

		    -- open file and write it
		    vim.cmd('e ' .. path)
		    vim.cmd('w')

		    -- Restore the register
		    vim.fn.setreg('"', old_reg, old_regtype)
		else
		    print("Not in visual mode")
		end
	    end, {})
	    vim.keymap.set("n", "<leader>zz", "vi[<cmd>NZK<CR>")
	    vim.keymap.set("n", "<leader>zk", function()
		local path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/zettelkasten/journal/"
		vim.cmd("e " .. path .. os.date("%Y-%m-%d", os.time()) .. ".md")
	    end)
	end
    }
}
