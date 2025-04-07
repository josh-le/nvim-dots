local state = {
    floating = {
	buf = -1,
	win = -1
    }
}

local function open_floating_window(opts)
    local opts = opts or {}

    -- Get current editor size
    local width = vim.o.columns
    local height = vim.o.lines

    -- Default size to 80% of screen if not provided
    local win_width = opts.width or math.floor(width * 0.8)
    local win_height = opts.height or math.floor(height * 0.8)

    -- Calculate center position
    local row = math.floor((height - win_height) / 3)
    local col = math.floor((width - win_width) / 2)

    -- Create a new buffer
    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
	buf = opts.buf
    else
	buf = vim.api.nvim_create_buf(false, true)
    end

    -- Window options
    local win_opts = {
        relative = "editor",
        width = win_width,
        height = win_height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded", -- Change to "single" or "double" if preferred
    }

    -- Open the floating window
    local win = vim.api.nvim_open_win(buf, true, win_opts)

    return { buf = buf, win = win }
end

local toggle_terminal = function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
	state.floating = open_floating_window { buf = state.floating.buf }
	if vim.bo[state.floating.buf].buftype ~= "terminal" then
	    vim.cmd.term()
	end
    else
	vim.api.nvim_win_hide(state.floating.win)
    end
end

vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})

