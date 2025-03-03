local autocmd_group = vim.api.nvim_create_augroup("CustomSettings", { clear = true })

-- Restore cursor position when opening file
vim.api.nvim_create_autocmd("BufReadPost", {
  group = autocmd_group,
  pattern = "*",
  callback = function()
    local line = vim.fn.line([['"]])
    if line > 1 and line <= vim.fn.line("$") then
      vim.cmd('normal! g`"')
    end
  end,
})


vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.bo.commentstring = "//%s"
  end,
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = autocmd_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('mariasolos/close_with_q', { clear = true }),
  desc = 'Close with <q>',
  pattern = {
    'git',
    'help',
    'man',
    'qf',
    'query',
    'scratch',
  },
  callback = function(args)
    vim.keymap.set('n', 'q', '<cmd>quit<cr>', { buffer = args.buf })
  end,
})


vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local fname = vim.fn.expand('%:t')
    if fname:match("%.env$") or
        fname:match("%.example$") or
        fname:match("^secret%.") or
        fname:match("%.config$") then
      vim.cmd('LspStop')
      vim.notify("LSP stopped after attachment")
    end
  end,
})
-- JavaScript, TypeScript, JSX, TSX, JSON
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd('CmdwinEnter', {
  group = vim.api.nvim_create_augroup('mariasolos/execute_cmd_and_stay', { clear = true }),
  desc = 'Execute command and stay in the command-line window',
  callback = function(args)
    vim.keymap.set({ 'n', 'i' }, '<S-Cr>', '<cr>q:', { buffer = args.buf })
  end,
})
