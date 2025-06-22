return {
    "kwakzalver/duckytype.nvim",
    config = function()
	require('duckytype').setup{
	    -- expected = "python_keywords",
	    number_of_words = 50,
	    -- average_word_length = 5.69,

	    -- local borders = { "none", "single", "double", "rounded", "solid", "shadow" }
	    window_config = {
		border = "rounded"
	    },
	}
	vim.keymap.set("n", "<leader>dt", function()
	    require('duckytype').Start("english_common")
	end)
	-- require('duckytype').Start("cpp_keywords")
	-- require('duckytype').Start("python_keywords")
	-- require('duckytype').Start("go_keywords")
    end
}
