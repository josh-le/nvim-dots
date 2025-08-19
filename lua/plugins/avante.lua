return {}
--[[
return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
	-- add any opts here
	-- for example
	provider = "ollama",
	ollama = {
	    endpoint = "http://127.0.0.1:11434",
	    model = "qwen2.5-coder",
	},
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
	"nvim-treesitter/nvim-treesitter",
	"stevearc/dressing.nvim",
	"nvim-lua/plenary.nvim",
	"MunifTanjim/nui.nvim",
    },
    opts = {

    },
}
--]]
