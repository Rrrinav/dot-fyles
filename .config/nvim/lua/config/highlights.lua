local M = {}

function M.setup()
    local bg_color = "#1e1e1e"
    -- local bg_color = "#0E051A"

    -- Change the background color of the line numbers
    -- vim.cmd([[highlight LineNr guibg=#1e1e2e guifg=#bbbbbb]])
    -- vim.cmd([[highlight CursorLineNr guibg=#1e1e2e guifg=#ffffff]])
    -- General highlights
    --
    local function get_hl_color(hl_group, attr)
        -- Get the highlight group definition (using 0 for global)
        local hl = vim.api.nvim_get_hl(0, { name = hl_group })
        -- Return the requested attribute (fg or bg)
        return hl[attr]
    end
    local statusline_fg = get_hl_color("StatusLine", "fg")
    local cursorline_bg = get_hl_color("CursorLine", "bg")
    local keyword_fg    = get_hl_color("Constant", "fg")
    local Operator_fg   = get_hl_color("Operator", "fg")

    vim.api.nvim_set_hl(0, "MsgArea",          { fg = "#b1b1ff" })
    vim.api.nvim_set_hl(0, "VertSplit",        { bg = bg_color, fg = statusline_fg })
    vim.api.nvim_set_hl(0, "Normal",           { bg = bg_color })
    vim.api.nvim_set_hl(0, "NormalFloat",      { bg = bg_color })
    vim.api.nvim_set_hl(0, "NormalNC",         { bg = bg_color })
    vim.api.nvim_set_hl(0, "NormalNCFloat",    { bg = bg_color })
    vim.api.nvim_set_hl(0, "NormalPopup",      { bg = bg_color })
    vim.api.nvim_set_hl(0, "NormalPopupFloat", { bg = bg_color })
    vim.api.nvim_set_hl(0, "NormalPopupNC",    { bg = bg_color })
    vim.api.nvim_set_hl(0, "EndOfBuffer",      { bg = bg_color, fg = bg_color })
    -- vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = bg_color })
    -- vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { bg = "#aaaaaa" })

    vim.api.nvim_set_hl(0, "FloatBorder",  { bg = bg_color }) -- General floating window border
    vim.api.nvim_set_hl(0, "WinSeparator", { bg = bg_color })

    vim.api.nvim_set_hl(0, "TabLineFill", { link="Normal" })
    vim.api.nvim_set_hl(0, "TabLine",     { bg = bg_color })
    -- Telescope highlights
    vim.api.nvim_set_hl(0, "TelescopeNormal",        { bg = bg_color })
    vim.api.nvim_set_hl(0, "TelescopeBorder",        { bg = bg_color })
    vim.api.nvim_set_hl(0, "TelescopePromptNormal",  { bg = bg_color })
    vim.api.nvim_set_hl(0, "TelescopePromptBorder",  { bg = bg_color })
    vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = bg_color })
    vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = bg_color })
    vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = bg_color })
    vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = bg_color })

    -- Border of which-key
    vim.api.nvim_set_hl(0, "WhichKeyBorder", { bg = bg_color })
    vim.api.nvim_set_hl(0, "BufferLineFill", { bg = bg_color })              -- Set background color for the entire BufferLine
    vim.api.nvim_set_hl(0, "BufferLineIcon", { bg = bg_color })              -- Set background color for icons in BufferLine

    vim.api.nvim_set_hl(0, "BufferLineDevIconDefault",      { bg = bg_color })    -- Default icon
    vim.api.nvim_set_hl(0, "BufferLineIconDefaultSelected", { bg = bg_color }) -- Selected icon
    -- Trouble windows
    vim.api.nvim_set_hl(0, "TroubleNormal",   { bg = bg_color })               -- Main Trouble window
    vim.api.nvim_set_hl(0, "TroubleFolded",   { bg = bg_color })               -- Folded items in Trouble window
    vim.api.nvim_set_hl(0, "TroubleCount",    { bg = bg_color })                -- Trouble count (e.g., number of errors)
    vim.api.nvim_set_hl(0, "TroubleIndent",   { bg = bg_color })               -- Indentation in Trouble window
    vim.api.nvim_set_hl(0, "TroubleText",     { bg = bg_color })                 -- Text in the Trouble window
    vim.api.nvim_set_hl(0, "TroublePreview",  { bg = bg_color })              -- Preview window for Trouble (if applicable)
    vim.api.nvim_set_hl(0, "TroubleLocation", { bg = bg_color })             -- Location (e.g., file path) in Trouble
end

return M
