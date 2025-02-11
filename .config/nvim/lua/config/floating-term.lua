local M = {}

-- Terminal window configuration
local function get_window_config()
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  return {
    relative = 'editor',
    row = row,
    col = col,
    width = width,
    height = height,
    style = 'minimal',
    border = {
      {"╭", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╮", "FloatBorder"},
      {"│", "FloatBorder"},
      {"╯", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╰", "FloatBorder"},
      {"│", "FloatBorder"},
    }
  }
end

function M.open_float_term(cmd, cwd)
  cmd = cmd or 'bash'

  -- Create empty buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Set buffer options
  vim.bo[buf].bufhidden = 'hide'
  vim.bo[buf].filetype = 'terminal'

  -- Create window
  local win = vim.api.nvim_open_win(buf, true, get_window_config())

  -- Start terminal inside the buffer
  vim.fn.termopen(cmd, {
    cwd = cwd,
    on_exit = function()
      vim.schedule(function()
        vim.api.nvim_buf_delete(buf, { force = true })
      end)
    end
  })

  -- Set up terminal mode mappings for double-ESC
  local function set_terminal_mappings()
    local opts = { buffer = buf, silent = true }
    vim.keymap.set('t', '<ESC><ESC>', '<C-\\><C-n>', opts)
  end

  -- Set up normal mode mapping for 'q' to close
  local function set_normal_mappings()
    local opts = { buffer = buf, silent = true }
    vim.keymap.set('n', 'q', function()
      vim.api.nvim_win_close(win, true)
    end, opts)
  end

  -- Apply the mappings
  set_terminal_mappings()
  set_normal_mappings()

  -- Auto-enter insert mode
  vim.cmd('startinsert')

  return win, buf
end

-- Create user commands
vim.api.nvim_create_user_command('Fterm', function(opts)
  local cmd = opts.args ~= "" and opts.args or "bash"
  M.open_float_term(cmd)
end, { nargs = '?' })

vim.api.nvim_create_user_command('Ftermdir', function(opts)
  local cmd = opts.args ~= "" and opts.args or "bash"
  local cwd = vim.fn.expand("%:p:h")
  M.open_float_term(cmd, cwd)
end, { nargs = '?' })

return M
