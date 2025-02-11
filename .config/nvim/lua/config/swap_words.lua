local M = {}

function M.setup()
  -- Variables to store the saved word and its exact position
  local saved_word = nil
  local saved_position = nil
  -- Namespace for custom highlights
  local highlight_ns = vim.api.nvim_create_namespace("SwapWordsHighlight")
  -- Function to clear the highlight
  local function clear_highlight()
    vim.api.nvim_buf_clear_namespace(0, highlight_ns, 0, -1)
  end
  -- Function to highlight a word at a specific position
  local function highlight_word(pos)
    clear_highlight()
    local line = pos[1] - 1
    local col_start = pos[2]
    local col_end = col_start + #vim.fn.expand('<cword>')
    vim.highlight.range(0, highlight_ns, "IncSearch", { line, col_start }, { line, col_end })
  end
  -- Function to reset state
  local function reset_state()
    saved_word = nil
    saved_position = nil
    clear_highlight()
    vim.notify("Operation cancelled.")
  end
  -- Function to save the current word and its exact position
  local function save_word()
    if saved_word and saved_position then
      reset_state()
    else
      saved_word = vim.fn.expand('<cword>')
      saved_position = vim.api.nvim_win_get_cursor(0)
      highlight_word(saved_position)
    end
  end
  -- Function to swap the saved word with the current word
  local function swap_word()
    if not saved_word or not saved_position then
      vim.notify("No word saved. Use '<leader>C' on the first word.")
      return
    end

    local current_word = vim.fn.expand('<cword>')  -- Get the current word under the cursor

    local new_pos = vim.api.nvim_win_get_cursor(0) -- Get current cursor position
    local length_diff = #saved_word - #current_word

    -- Replace the current word with the saved word
    vim.cmd('normal! ciw' .. saved_word)

    -- Move to the saved position
    -- -- If moving back
    if length_diff < 0 and new_pos[2] < saved_position[2] then
      -- If the saved word is shorter than the current word, adjust the cursor position
      saved_position[2] = saved_position[2] + length_diff
      vim.api.nvim_win_set_cursor(0, saved_position)
    end
    -- -- If moving forward
    vim.api.nvim_win_set_cursor(0, saved_position)

    if length_diff > 0 then
      -- If the saved word is longer than the current word, adjust the cursor position
      vim.cmd('normal! ' .. length_diff .. 'l')
    end

    -- Replace the saved word with the current word
    vim.cmd('normal! ciw' .. current_word)
    -- Clear highlights after the swap

    clear_highlight()

    -- Calculate the correct cursor position after the swap
    local final_col = new_pos[2]
    -- If moving forward (current position > saved position)
    if new_pos[2] > saved_position[2] then
      -- Move cursor to the right by the difference in length
      final_col = final_col - length_diff
    end

    -- Set cursor to the correct position
    vim.api.nvim_win_set_cursor(0, { new_pos[1], final_col })
    saved_word = nil
    saved_position = nil
  end

  -- Function to move to the next word (skipping punctuation)
  local function move_to_next_word()
    local initial_pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd("normal! w")
    local curr_line = vim.api.nvim_get_current_line()
    local curr_pos = vim.api.nvim_win_get_cursor(0)
    local char_under_cursor = curr_line:sub(curr_pos[2] + 1, curr_pos[2] + 1)

    -- Keep moving forward while we're on punctuation or empty space
    while char_under_cursor:match('^%p$') or char_under_cursor:match('^%s$') do
      -- Check if we've reached the end of the line
      if curr_pos[2] + 1 >= #curr_line then
        -- If we couldn't find a word, go back to initial position
        vim.api.nvim_win_set_cursor(0, initial_pos)
        return
      end
      vim.cmd("normal! w")
      curr_line = vim.api.nvim_get_current_line()
      curr_pos = vim.api.nvim_win_get_cursor(0)
      char_under_cursor = curr_line:sub(curr_pos[2] + 1, curr_pos[2] + 1)
    end
  end
  -- Function to move to the previous word (skipping punctuation)
  local function move_to_prev_word()
    local initial_pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd("normal! b")
    local curr_line = vim.api.nvim_get_current_line()
    local curr_pos = vim.api.nvim_win_get_cursor(0)
    local char_under_cursor = curr_line:sub(curr_pos[2] + 1, curr_pos[2] + 1)

    -- Keep moving backward while we're on punctuation or empty space
    while char_under_cursor:match('^%p$') or char_under_cursor:match('^%s$') do
      -- Check if we've reached the start of the line
      if curr_pos[2] == 0 then
        -- If we couldn't find a word, go back to initial position
        vim.api.nvim_win_set_cursor(0, initial_pos)
        return
      end
      vim.cmd("normal! b")
      curr_line = vim.api.nvim_get_current_line()
      curr_pos = vim.api.nvim_win_get_cursor(0)
      char_under_cursor = curr_line:sub(curr_pos[2] + 1, curr_pos[2] + 1)
    end
  end
  -- Keybindings
  vim.keymap.set('n', '<leader>C', save_word, { desc = "Save the current word and position for swapping" })
  vim.keymap.set('n', '<leader>R', swap_word, { desc = "Swap with saved word and go to original position" })
  -- Alt-m/Alt-M commands with punctuation-skipping movement
  vim.keymap.set('n', '<A-m>', function()
    save_word()
    move_to_next_word()
    swap_word()
  end, { noremap = true, silent = true, desc = "Save the current word, move to the next word, and swap" })
  vim.keymap.set('n', '<A-M>', function()
    save_word()
    move_to_prev_word()
    swap_word()
  end, { noremap = true, silent = true, desc = "Save the current word, move to the previous word, and swap" })
end

return M
