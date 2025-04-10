return {
    -- mason for downloading LSPs
    {
	"williamboman/mason.nvim",
	config = function()
	    require("mason").setup()
	end
    },
    -- lspconfig for configuring them
    {
	"neovim/nvim-lspconfig",
	config = function()
	    vim.keymap.set("n", "grn", vim.lsp.buf.rename)
	    vim.keymap.set("n", "gra", vim.lsp.buf.code_action)
	end
    },


	--    -- blink for completion
	--    {
	-- 'saghen/blink.cmp',
	-- -- optional: provides snippets for the snippet source
	-- dependencies = 'rafamadriz/friendly-snippets',
	--
	-- -- use a release tag to download pre-built binaries
	-- version = '*',
	--
	-- opts = {
	--     -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept, C-n/C-p for up/down)
	--     -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys for up/down)
	--     -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
	--     --
	--     -- All presets have the following mappings:
	--     -- C-space: Open menu or open docs if already open
	--     -- C-e: Hide menu
	--     -- C-k: Toggle signature help
	--     --
	--     -- See the full "keymap" documentation for information on defining your own keymap.
	--     keymap = { preset = 'default' },
	--
	--     appearance = {
	-- 	-- Sets the fallback highlight groups to nvim-cmp's highlight groups
	-- 	-- Useful for when your theme doesn't support blink.cmp
	-- 	-- Will be removed in a future release
	-- 	use_nvim_cmp_as_default = true,
	-- 	-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
	-- 	-- Adjusts spacing to ensure icons are aligned
	-- 	nerd_font_variant = 'mono'
	--     },
	--
	--     -- Default list of enabled providers defined so that you can extend it
	--     -- elsewhere in your config, without redefining it, due to `opts_extend`
	--     sources = {
	-- 	default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer', 'obsidian' },
	-- 	providers = {
	-- 	    lazydev = {
	-- 		name = "LazyDev",
	-- 		module = "lazydev.integrations.blink",
	-- 		-- make lazydev completions top priority (see `:h blink.cmp`)
	-- 		score_offset = 100,
	-- 	    }
	-- 	}
	--     },
	--
	--     -- Blink.cmp uses a Rust fuzzy matcher by default for typo resistance and significantly better performance
	--     -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
	--     -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
	--     --
	--     -- See the fuzzy documentation for more information
	--     fuzzy = { implementation = "prefer_rust_with_warning" }
	-- },
	-- opts_extend = { "sources.default" }
	--    },



    -- nvim-cmp setup
    {
	'hrsh7th/cmp-nvim-lsp'
    },
    {
	'hrsh7th/cmp-buffer'
    },
    {
	'hrsh7th/cmp-path'
    },
    {
	'hrsh7th/cmp-cmdline'
    },
    {
	'hrsh7th/nvim-cmp',
	config = function()
	    vim.opt.completeopt = { "menu", "menuone", "noselect" } -- Already common for nvim-cmp
	    vim.api.nvim_set_keymap('i', '<C-n>', '<NOP>', { noremap = true, silent = true })
	    vim.api.nvim_set_keymap('i', '<C-p>', '<NOP>', { noremap = true, silent = true })
	    vim.api.nvim_set_keymap('i', '<C-Space>', '<NOP>', { noremap = true, silent = true })
	    vim.api.nvim_set_keymap('i', '<C-f>', '<NOP>', { noremap = true, silent = true })
	    vim.api.nvim_set_keymap('i', '<C-b>', '<NOP>', { noremap = true, silent = true })
	    local cmp = require'cmp'
	    cmp.setup({
		sources = cmp.config.sources({
		    { name = 'nvim_lsp' },
		    -- { name = 'buffer' }
		}),
		mapping = cmp.mapping.preset.insert({
		    ['<C-n>'] = cmp.mapping.select_next_item(),
		    ['<C-p>'] = cmp.mapping.select_prev_item(),
		    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
		    ['<C-f>'] = cmp.mapping.scroll_docs(4),
		    ['<C-Space>'] = cmp.mapping.open_docs(),
		    ['<C-y>'] = cmp.mapping.complete(),
		    ['<C-e>'] = cmp.mapping.abort(),
		})
	    })
	end
    },



    -- mason LSP config for bridging between lspconfig and mason
    {
	"williamboman/mason-lspconfig.nvim",
	config = function()
	    require("mason-lspconfig").setup()

	    -- -- for blink
	    -- local capabilities = require("blink.cmp").get_lsp_capabilities()
	    -- for nvim-cmp
	    local capabilities = require("cmp_nvim_lsp").default_capabilities()
	    -- individual lsp server configuration
	    require("lspconfig").lua_ls.setup({
		capabilities = capabilities
	    })
	    require('lspconfig').pyright.setup({
		capabilities = capabilities
	    })
	    require('lspconfig').gopls.setup({
		capabilities = capabilities
	    })
	    require('lspconfig').clangd.setup({
		on_init = function(client)
		    client.server_capabilities.semanticTokensProvider = nil
		    client.server_capabilities.documentFormattingProvider = false
		    client.server_capabilities.documentFormattingRangeProvider = false
		end,
		capabilities = capabilities,
	    })
	    require('lspconfig').jdtls.setup({
		capabilities = capabilities
	    })
	    require('lspconfig').zls.setup({
		capabilities = capabilities
	    })
	    require('lspconfig').sqlls.setup({
		capabilities = capabilities
	    })
	    require('lspconfig').dockerls.setup({
		capabilities = capabilities
	    })
	    require('lspconfig').ts_ls.setup({
		capabilities = capabilities
	    })
	    require('lspconfig').jsonls.setup({
		capabilities = capabilities
	    })
	    require('lspconfig').html.setup({
		capabilities = capabilities
	    })
	    require('lspconfig').cucumber_language_server.setup({
		capabilities = capabilities,
	    })
	    require('lspconfig').lemminx.setup({
		capabilities = capabilities
	    })
	    require('lspconfig').bashls.setup({
		capabilities = capabilities
	    })
	end
    },
}
