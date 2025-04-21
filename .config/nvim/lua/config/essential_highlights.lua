vim.opt.termguicolors = true
local hl = vim.api.nvim_set_hl

local function get_hl_color(hl_group, attr)
  -- Get the highlight group definition (using 0 for global)
  local hl = vim.api.nvim_get_hl(0, { name = hl_group })
  -- Return the requested attribute (fg or bg)
  return hl[attr]
end

local Operator_fg     = get_hl_color("Operator", "fg")
local float_b_bg      = get_hl_color("NormalFloat", 'bg')
local float_b_fg      = "#fafafa"
local statusline_fg   = get_hl_color("StatusLine", "fg")
local cursorline_bg   = get_hl_color("CursorLine", "bg")
local keyword_fg      = get_hl_color("Constant", "fg")
local Operator_fg     = get_hl_color("Operator", "fg")
local TelescopeNormal = get_hl_color("TelescopeNormal", "bg")

hl(0, "FloatBorder",             { bg = float_b_bg, fg = float_b_fg})
hl(0, "FloatTitle",              { bg = float_b_bg, fg = Operator_fg })
hl(0, "NormalNCFloat",           { bg = float_b_bg, fg = float_b_fg })
hl(0, "NormalPopupNC",           { bg = float_b_bg, fg = float_b_fg })
hl(0, "FloatShadow",             { bg = float_b_bg, fg = float_b_fg })
hl(0, "FloatShadowThrough",      { bg = float_b_bg, fg = float_b_fg })

hl(0, "TelescopeBorder",         { bg = TelescopeNormal, fg = float_b_fg })
hl(0, "TelescopeSelection",      { fg = keyword_fg , bg = cursorline_bg, bold = true })
hl(0, "TelescopeSelectionCaret", { fg = keyword_fg, bg = cursorline_bg })
hl(0, "TelescopeMultiSelection", { link = "Visual" })
hl(0, "TelescopeMatching",       { link = "Search" })
hl(0, "TelescopePromptPrefix",   { link = "Normal" })
hl(0, "TelescopePromptNormal",   { link = "Normal" })
hl(0, "TelescopePromptBorder",   { link = "Normal" })
hl(0, "TelescopeNormal",         { link = "Normal" })
