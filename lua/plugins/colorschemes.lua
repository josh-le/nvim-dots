local function random()
    local schemes = {"moonfly", "gruvbox", "oscura", "makurai", "everforest", "cyberdream", "kanagawa", "catppuccin"}
    math.randomseed(os.time())
    vim.cmd("colorscheme " .. schemes[math.random(#schemes)])
end

local function select_colorscheme()
    -- vim.o.background = "light"
    vim.o.background = "dark"
    -- vim.cmd("colorscheme moonfly")
    -- vim.cmd("colorscheme gruvbox")
    -- vim.cmd("colorscheme oscura")
    -- vim.cmd("colorscheme makurai")
    -- vim.cmd("colorscheme everforest")
    -- vim.cmd("colorscheme cyberdream")
    -- vim.cmd("colorscheme kanagawa")
    -- vim.cmd("colorscheme catppuccin")
    random()
end

return {
    {
	"bluz71/vim-moonfly-colors", name = "moonfly",
	config = function()
	    select_colorscheme()
	end,
    },
    {
	"morhetz/gruvbox",
	config = function()
	    vim.g.gruvbox_italic = 1
	end

    },
    {
	"vinitkumar/oscura-vim",
	config = function()
	end
    },
    {
	"Skardyy/makurai-nvim",
	config = function()
	end
    },
    {
	"sainnhe/everforest",
	config = function()
	end
    },
    {
	"scottmckendry/cyberdream.nvim",
	config = function()
	end
    },
    {
	"rebelot/kanagawa.nvim",
	config = function()
	end
    },
    {
	"catppuccin/nvim",
	config = function()
	    require("catppuccin").setup({
		-- flavour = "latte"
		-- flavour = "frappe"
		-- flavour = "macchiato"
		flavour = "mocha"
	    })
	end
    },
}

