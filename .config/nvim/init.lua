require("config.lazy")

vim.cmd.colorscheme("neodarcula") -- Or any other theme
require("config.essential_highlights")
-- require("config.highlights")
require("config.keymaps")
require("config.autocmds")
require("config.basic_gui").setup()
require("config.user_commands").setup()
require("config.swap_words").setup()
require("config.floating-term")

vim.opt.termguicolors = true
vim.keymap.del("", "<Tab>")

vim.api.nvim_set_hl(0, "TabLineFill", { link ="Normal" })
vim.api.nvim_set_hl(0, "TabLine"    , { link = "Normal" })
vim.cmd([[
  cnoreabbrev <expr> lua getcmdtype() == ':' && getcmdline() == 'lua' ? '󰢱 ' : 'lua'
]])
