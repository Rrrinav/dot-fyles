vim.opt.termguicolors = true

local function get_hl_color(hl_group, attr)
  -- Get the highlight group definition (using 0 for global)
  local hl = vim.api.nvim_get_hl(0, { name = hl_group })
  -- Return the requested attribute (fg or bg)
  return hl[attr]
end

local Operator_fg     = get_hl_color("Operator", "fg")
local float_b_bg      = get_hl_color("NormalFloat", 'bg')
local statusline_fg   = get_hl_color("StatusLine", "fg")
local cursorline_bg   = get_hl_color("CursorLine", "bg")
local keyword_fg      = get_hl_color("Constant", "fg")
local Operator_fg     = get_hl_color("Operator", "fg")
local TelescopeNormal = get_hl_color("TelescopeNormal", "bg")
local str_fg          = get_hl_color("@string", "fg")
local b_str_fg        = get_hl_color("String", "fg")
local string_nord = "#88a8c8";
b_str_fg = string_nord
str_fg = string_nord

vim.api.nvim_set_hl(0, "@string",       { fg = str_fg, italic = true })
vim.api.nvim_set_hl(0, "String",        { fg = b_str_fg, italic = true })

vim.api.nvim_set_hl(0, "BlinkCmpKind",       { ctermfg = 14, fg= Operator_fg })
-- Define compile-mode highlights
vim.api.nvim_set_hl(0, "CompileModeError",            { fg = "#ff5555", bold = true })      -- Soft red for errors
vim.api.nvim_set_hl(0, "CompileModeWarning",          { fg = "#ffcc00", bold = true })      -- Golden yellow for warnings
vim.api.nvim_set_hl(0, "CompileModeInfo",             { fg = "#50fa7b", bold = true })      -- Neon green for info
vim.api.nvim_set_hl(0, "CompileModeMessage",          { fg = "#f8f8f2" })                   -- Soft white for messages
vim.api.nvim_set_hl(0, "CompileModeMessageRow",       { fg = "#ff8888" })                   -- Neutral gray for row numbers
vim.api.nvim_set_hl(0, "CompileModeMessageCol",       { fg = "#ff8888" })                   -- Neutral gray for column numbers
vim.api.nvim_set_hl(0, "CompileModeCommandOutput",    { fg = "#a0a0a0" })                   -- Dim gray for command output
vim.api.nvim_set_hl(0, "CompileModeOutputFile",       { fg = "#ff9ff3", italic = true })    -- Warm orange for output file paths
vim.api.nvim_set_hl(0, "CompileModeCheckResult",      { fg = "#56c7ff" })                   -- Electric blue for check results
vim.api.nvim_set_hl(0, "CompileModeCheckTarget",      { fg = "#ff79c6" })                   -- Vibrant pink for check targets
vim.api.nvim_set_hl(0, "CompileModeDirectoryMessage", { fg = "#8be9fd" })                   -- Cyan sky blue for directory messages
vim.api.nvim_set_hl(0, "CompileModeErrorLocus",       { bg = "#ff4444", fg = "#ffffff" })   -- Deep red background for error locus

vim.api.nvim_set_hl(0, "FloatBorder",             { bg = float_b_bg })
vim.api.nvim_set_hl(0, "FloatTitle",              { bg = float_b_bg, fg = Operator_fg })
vim.api.nvim_set_hl(0, "NormalNCFloat",           { bg = float_b_bg })
vim.api.nvim_set_hl(0, "NormalPopupNC",           { bg = float_b_bg })
vim.api.nvim_set_hl(0, "FloatShadow",             { bg = float_b_bg })
vim.api.nvim_set_hl(0, "FloatShadowThrough",      { bg = float_b_bg })
vim.api.nvim_set_hl(0, "TelescopeBorder",         { bg = TelescopeNormal })
vim.api.nvim_set_hl(0, "TelescopeSelection",      { fg = keyword_fg , bg = cursorline_bg, bold = true })
vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = keyword_fg, bg = cursorline_bg })
vim.api.nvim_set_hl(0, "TelescopeMultiSelection", { link = "Visual" })
vim.api.nvim_set_hl(0, "TelescopeMatching",       { link = "Search" })
vim.api.nvim_set_hl(0, "TelescopePromptPrefix",   { link = "Normal" })
