-- For better paste behavior overall
vim.opt.mouse = "a" -- Enable mouse support

-- Oil nvim
vim.keymap.set("n", "-", "<Cmd>Oil<cr>")
vim.keymap.set("n", "<leader>fp", function()
    require("oil").open_float()
end, { desc = "Open Oil in a floating window" })
vim.keymap.set("n", "<leader>fo", function()
    -- Open the current working directory (CWD) in a floating window
    require("oil").open_float(vim.fn.getcwd())
end, { desc = "Open Oil in a floating window with CWD" })

vim.keymap.set(
    'n', '<leader>xf',
    function()
        vim.diagnostic.open_float(nil, { border = "rounded" })
    end,
    { noremap = true, silent = true, desc = "Open diagnostic in float" }
)

vim.api.nvim_set_keymap('n', '<leader>cf',
    ":lua vim.lsp.buf.format()<CR>",
    { noremap = true, silent = true, nowait = true, desc = "Format buffer" }
)

vim.keymap.set("n", "<A-t>", "<leader>Cw<leader>R", { noremap = true, silent = true, desc = "Swap words" })

local function hide_diagnostics()
    vim.diagnostic.config({ -- https://neovim.io/doc/user/diagnostic.html
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

vim.keymap.set("n", "<leader>fe",
    function()
        Snacks.explorer();
    end,
    { noremap = true, desc = "Open file explorer in side" })

vim.keymap.set("n", "<leader>do",
    function()
        Snacks.picker.pickers(
            {
                finder = "meta_pickers",
                format = "text",
                layout = { preset = "ivy" }, -- Add this line to set the default layout to ivy
                confirm = function(picker, item)
                    picker:close()
                    if item then
                        vim.schedule(function()
                            Snacks.picker(item.text, { layout = { preset = "ivy" } })
                        end)
                    end
                end,
            });
    end,
    { noremap = true, desc = "Open picker for pickers, bwaha!" });

vim.keymap.set("n", "<leader>xh", hide_diagnostics, { noremap = true, desc = "Hide diagnostics" })
vim.keymap.set("n", "<leader>xs", show_diagnostics, { noremap = true, desc = "Show diagnostics" })
vim.api.nvim_set_keymap('n', '<leader>ca', ':lua vim.b.completion = false<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ce', ':lua vim.b.completion = true<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>xt", ":TodoQuickFix<CR>", { noremap = true, desc = "List todos" })
vim.keymap.set("n", "<leader>fv", '<Cmd>vsplit | term<Cr>', { noremap = true, desc = "Vertical split terminal" })
vim.keymap.set("n", "<leader>ff", '<Cmd>Fterm<Cr>', { noremap = true, desc = "Floating terminal" })
-- Move selected lines up/down in visual mode
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Move current line up/down in normal mode
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })


-- -- Keeping cursor centred
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll downwards' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll upwards' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next result' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous result' })

-- Indent while remaining in visual mode.
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Poweful <esc>.
vim.keymap.set({ 'i', 's', 'n' }, '<esc>', function()
    if require('luasnip').expand_or_jumpable() then
        require('luasnip').unlink_current()
    end
    vim.cmd 'noh'
    return '<esc>'
end, { desc = 'Escape, clear hlsearch, and stop snippet session', expr = true })


-- Exit terminal mode with <C-/>
vim.keymap.set("t", "<C-/>", "<C-\\><C-n>:q<Cr>", { desc = "Exit terminal mode" })
vim.keymap.set('n', '<leader>cc', ":Compile", { desc = "Enter compile mode", noremap = true })


-- Switch between windows.
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to the left window', remap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to the bottom window', remap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to the top window', remap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to the right window', remap = true })
vim.keymap.set('n', '<leader>|', '<Cmd>vsplit<Cr>', { desc = 'Vertical split', noremap = true })
vim.keymap.set('n', '<leader>-', '<Cmd>split<Cr>', { desc = 'Horizontal split', noremap = true })

-- Buffers
vim.keymap.set("n", "<leader>bo", function()
    local current = vim.fn.bufnr("%")
    for _, buf in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
        if buf.bufnr ~= current then
            vim.cmd("bd " .. buf.bufnr)
        end
    end
end, { desc = "Close other buffers" })
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bx", function()
    if #vim.fn.getbufinfo({ buflisted = 1 }) > 1 then
        vim.cmd("bd")
    else
        vim.notify("Can't close the last buffer!")
    end
end, { desc = "Close buffer safely" })

vim.keymap.set('n', '<leader>Q', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]],
    { desc = 'Replace word under cursor' })
