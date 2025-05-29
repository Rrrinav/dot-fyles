-- ---------------------------------------------------- GENERAL SETTINGS ----------------------------------------------------
vim.opt.mouse = "a"  -- Enable mouse support

-- -------------------------------------------------------- OIL NVIM --------------------------------------------------------
-- Open Oil with '-'
vim.keymap.set("n", "-", "<Cmd>Oil<cr>")

-- Open Oil in a floating window
vim.keymap.set("n", "<leader>fp", function()
  require("oil").open_float()
end, { desc = "Open Oil in a floating window" })

-- Open Oil in a floating window with CWD
vim.keymap.set("n", "<leader>fo", function()
  require("oil").open_float(vim.fn.getcwd())
end, { desc = "Open Oil in a floating window with CWD" })

-- ----------------------------------------------------- DIAGNOSTICS ---------------------------------------------------------
-- Open diagnostic in a float
vim.keymap.set('n', '<leader>xf', function()
  vim.diagnostic.open_float(nil, { border = "rounded" })
end, { noremap = true, silent = true, desc = "Open diagnostic in float" })

-- Show/Hide diagnostics
local function hide_diagnostics()
  vim.diagnostic.config({
    virtual_text = false,
    signs = false,
    underline = false,
  })
end

local function show_diagnostics()
  vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
  })
end

vim.keymap.set("n", "<leader>xh", hide_diagnostics, { noremap = true, desc = "Hide diagnostics" })
vim.keymap.set("n", "<leader>xs", show_diagnostics, { noremap = true, desc = "Show diagnostics" })

-- ----------------------------------------------------- LSP -----------------------------------------------------
-- Format buffer using LSP
vim.api.nvim_set_keymap('n', '<leader>cf', ":lua vim.lsp.buf.format()<CR>", {
  noremap = true,
  silent = true,
  nowait = true,
  desc = "Format buffer"
})

-- Format selected text using LSP
vim.keymap.set("v", "<leader>cf", function()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  vim.lsp.buf.format({
    range = {
      ["start"] = { start_pos[2], start_pos[3] - 1 },
      ["end"] = { end_pos[2], end_pos[3] },
    },
  })
end, { desc = "Format selection with LSP" })

-- --------------------------------------------------- CUSTOM COMMANDS ---------------------------------------------------
-- Swap words using <A-t>
vim.keymap.set("n", "<A-t>", "<leader>Cw<leader>R", { noremap = true, silent = true, desc = "Swap words" })

-- Open Snacks explorer
vim.keymap.set("n", "<leader>fe", function()
  Snacks.explorer()
end, { noremap = true, desc = "Open file explorer in side" })

-- Open Picker for pickers
vim.keymap.set("n", "<leader>do", function()
  Snacks.picker.pickers({
    finder = "meta_pickers",
    format = "text",
    layout = { preset = "ivy" },
    confirm = function(picker, item)
      picker:close()
      if item then
        vim.schedule(function()
          Snacks.picker(item.text, { layout = { preset = "ivy" } })
        end)
      end
    end,
  })
end, { noremap = true, desc = "Open picker for pickers" })

-- Toggle completion
vim.api.nvim_set_keymap('n', '<leader>ca', ':lua vim.b.completion = false<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ce', ':lua vim.b.completion = true<CR>', { noremap = true, silent = true })

-- Todo list
vim.keymap.set("n", "<leader>xt", ":TodoQuickFix<CR>", { noremap = true, desc = "List todos" })

-- Open terminal in vertical split or floating
vim.keymap.set("n", "<leader>fv", '<Cmd>vsplit | term<Cr>', { noremap = true, desc = "Vertical split terminal" })
vim.keymap.set("n", "<leader>ff", '<Cmd>Fterm<Cr>', { noremap = true, desc = "Floating terminal" })

-- -------------------------------------------------- WINDOW MANAGEMENT ---------------------------------------------------
-- Open horizontal and vertical splits
vim.keymap.set("n", "<leader>|", ":vsplit<CR>", { noremap = true, desc = "Open vertical split" })
vim.keymap.set("n", "<leader>-", ":split<CR>" , { noremap = true, desc = "Open horizontal split" })
-- Window movement without 'W'
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, desc = "Move to right window" })
-- Move selected lines in visual mode
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Move current line in normal mode
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })

-- --------------------------------------------------- SCROLLING & NAVIGATION ----------------------------------------------
-- Keep cursor centered while scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll downwards' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll upwards' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next result' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous result' })

-- Indentation while remaining in visual mode
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- --------------------------------------------------- POWERFUL ESCAPE ----------------------------------------------------
-- Escape, clear search highlight, and stop snippet session
vim.keymap.set({ 'i', 's', 'n' }, '<esc>', function()
  if require('luasnip').expand_or_jumpable() then
    require('luasnip').unlink_current()
  end
  vim.cmd 'noh'
  return '<esc>'
end, { desc = 'Escape, clear hlsearch, and stop snippet session', expr = true })

-- --------------------------------------------------- TERMINAL MODE ------------------------------------------------------
-- Exit terminal mode with <C-/>
vim.keymap.set("t", "<C-/>", "<C-\\><C-n>:q<Cr>", { desc = "Exit terminal mode" })

-- --------------------------------------------------- BUFFER MANAGEMENT --------------------------------------------------
-- Close other buffers
vim.keymap.set("n", "<leader>bo", function()
  local current = vim.fn.bufnr("%")
  for _, buf in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
    if buf.bufnr ~= current then
      vim.cmd("bd " .. buf.bufnr)
    end
  end
end, { desc = "Close other buffers" })

-- Safely close buffer
vim.keymap.set("n", "<leader>bx", function()
  if #vim.fn.getbufinfo({ buflisted = 1 }) > 1 then
    vim.cmd("bd")
  else
    vim.notify("Can't close the last buffer!")
  end
end, { desc = "Close buffer safely" })

-- --------------------------------------------------- MISC COMMANDS -----------------------------------------------------
-- Replace word under cursor
vim.keymap.set('n', '<leader>Q', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]],
  { desc = 'Replace word under cursor' })

-- Buffer grab using Rabbit
vim.keymap.set('n', "<leader>bg", ":Rabbit<Cr>", { desc = "Buffer grab using rabbit" })

