local state = {
    floating = {
	buf = -1,
	win = -1
    },
    run_command = "",
    p = 1,
    placement = {
	"floating",
	"bottom",
	"right",
    }
}

local function open_floating_window(opts)
    opts = opts or {}

    local width = vim.o.columns
    local height = vim.o.lines

    local win_width = opts.width or math.floor(width * 0.8)
    local win_height = opts.height or math.floor(height * 0.8)

    local row = math.floor((height - win_height) / 3)
    local col = math.floor((width - win_width) / 2)

    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
	buf = opts.buf
    else
	buf = vim.api.nvim_create_buf(false, true)
    end

    local win_opts = {
	relative = "editor",
	width = win_width,
	height = win_height,
	row = row,
	col = col,
	style = "minimal",
	border = "rounded", -- Change to "single" or "double" if preferred
    }
    local win = vim.api.nvim_open_win(buf, true, win_opts)
    if state.placement[state.p] == "bottom" then
	local term_height = math.floor(math.max(5, height / 3))
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, term_height)
    elseif state.placement[state.p] == "right" then
	local term_width = math.floor(math.max(12, width * .4))
	vim.cmd.wincmd("L")
	vim.api.nvim_win_set_width(0, term_width)
    end


    local function is_transparent()
	local hl = vim.api.nvim_get_hl(0, { name = "Normal" })
	return hl.bg == nil
    end

    if is_transparent() then
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    end

    return { buf = buf, win = win }
end

local toggle_terminal = function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
	state.floating = open_floating_window { buf = state.floating.buf }
	if vim.bo[state.floating.buf].buftype ~= "terminal" then
	    vim.cmd.term()
	    local term_buf = vim.api.nvim_win_get_buf(state.floating.win)
	    state.floating.buf = term_buf
	    vim.keymap.set("n", "S", function()
		state.p = math.max(1, (state.p + 1) % (#state.placement + 1))
		vim.api.nvim_win_hide(state.floating.win)
		state.floating = open_floating_window { buf = state.floating.buf }
	    end, {
		buffer = term_buf
	    })
	end
    else
	vim.api.nvim_win_hide(state.floating.win)
    end
end

vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
vim.keymap.set({"n", "t"}, "<leader>t", "<cmd>Floaterminal<CR>")
-- vim.keymap.set("t", "", "<cmd>Floaterminal<CR>")
vim.keymap.set({"n", "t"}, "TR", function()
    state.run_command = vim.fn.input("Enter run command: ")
end)
vim.keymap.set("n", "Tr", function()
    if state.run_command == "" then
	state.run_command = vim.fn.input("Enter run command: ")
    end
    toggle_terminal()
    vim.api.nvim_input("i" .. state.run_command .. "<CR>")
end)

local augroup = vim.api.nvim_create_augroup("Floaterminal", { clear = true })
vim.api.nvim_create_autocmd("VimLeave", {
    group = augroup,
    desc = "Kill floaterminal when quitting Neovim",
    callback = function()
        if vim.api.nvim_buf_is_valid(state.floating.buf) then
            vim.api.nvim_buf_delete(state.floating.buf, { force = true })
        end
    end,
})