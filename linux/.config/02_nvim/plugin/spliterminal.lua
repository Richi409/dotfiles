local state = {
  terminal = {
    buf = -1,
    win = -1,
  }
}

local function create_split_window(opts)
  opts = opts or {}
  local height = opts.height or 15

  -- Create or reuse buffer
  local buf
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  -- Create split at bottom
  vim.cmd("botright split")

  local win = vim.api.nvim_get_current_win()

  -- Set height
  vim.api.nvim_win_set_height(win, height)

  -- Attach buffer
  vim.api.nvim_win_set_buf(win, buf)

  return { buf = buf, win = win }
end

local toggle_split_terminal = function()
  if not vim.api.nvim_win_is_valid(state.terminal.win) then
    state.terminal = create_split_window { buf = state.terminal.buf }

    -- Start terminal if buffer isn't already one
    if vim.bo[state.terminal.buf].buftype ~= "terminal" then
      vim.cmd("terminal")
    end

    -- Enter insert mode immediately
    vim.cmd("startinsert")
  else
    -- Hide window but keep buffer alive
    vim.api.nvim_win_hide(state.terminal.win)
  end
end

vim.api.nvim_create_user_command("SplitTerminal", toggle_split_terminal, {})

vim.keymap.set({"n", "t"}, "<leader>st", function()
  toggle_split_terminal()
end, { desc = "Toggle bottom terminal" })
