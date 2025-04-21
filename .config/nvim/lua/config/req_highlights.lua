local hl = vim.api.nvim_set_hl

local function get_hl_color(hl_group, attr)
  -- Get the highlight group definition (using 0 for global)
  local hl = vim.api.nvim_get_hl(0, { name = hl_group })
  -- Return the requested attribute (fg or bg)
  return hl[attr]
end

hl(0, "MultiCursorCursor", {
  bg = "#666666",
  fg = "#ffffff",
  bold = true,
  nocombine = true
})
-- Visual selections: semi-transparent blue
hl(0, "MultiCursorVisual", {
  bg = "#264f78",
  blend = 50
})
-- Sign column indicators
hl(0, "MultiCursorSign", {
  fg = "#666666",
  bold = true
})
-- Disabled cursor state: dimmed purple
hl(0, "MultiCursorDisabledCursor", {
  bg = "#663399",
  fg = "#cccccc"
})
-- Disabled visual state: very dim blue
hl(0, "MultiCursorDisabledVisual", {
  bg = "#1a3352",
  blend = 70
})
-- Disabled sign state
hl(0, "MultiCursorDisabledSign", {
  fg = "#663399",
  blend = 50
})


local str_fg          = get_hl_color("@string", "fg")
local b_str_fg        = get_hl_color("String", "fg")
local string_nord = "#88a8c8";

b_str_fg = string_nord
str_fg = string_nord

vim.api.nvim_set_hl(0, "@string",       { fg = str_fg}) --, italic = true })
vim.api.nvim_set_hl(0, "String",        { fg = b_str_fg}) --, italic = true })
vim.api.nvim_set_hl(0, "@namespace",    { italic = false })

hl(0, "BlinkCmpKind",       { ctermfg = 14, fg= Operator_fg })
-- Define compile-mode highlights
hl(0, "CompileModeError",            { fg = "#ff5555", bold = true })      -- Soft red for errors
hl(0, "CompileModeWarning",          { fg = "#ffcc00", bold = true })      -- Golden yellow for warnings
hl(0, "CompileModeInfo",             { fg = "#50fa7b", bold = true })      -- Neon green for info
hl(0, "CompileModeMessage",          { fg = "#f8f8f2" })                   -- Soft white for messages
hl(0, "CompileModeMessageRow",       { fg = "#ff8888" })                   -- Neutral gray for row numbers
hl(0, "CompileModeMessageCol",       { fg = "#ff8888" })                   -- Neutral gray for column numbers
hl(0, "CompileModeCommandOutput",    { fg = "#a0a0a0" })                   -- Dim gray for command output
hl(0, "CompileModeOutputFile",       { fg = "#ff9ff3", italic = true })    -- Warm orange for output file paths
hl(0, "CompileModeCheckResult",      { fg = "#56c7ff" })                   -- Electric blue for check results
hl(0, "CompileModeCheckTarget",      { fg = "#ff79c6" })                   -- Vibrant pink for check targets
hl(0, "CompileModeDirectoryMessage", { fg = "#8be9fd" })                   -- Cyan sky blue for directory messages
hl(0, "CompileModeErrorLocus",       { bg = "#ff4444", fg = "#ffffff" })   -- Deep red background for error locus
