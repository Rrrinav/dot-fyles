require("config.lazy")

vim.cmd.colorscheme("nord") -- Or any other theme
require("config.essential_highlights")
require("config.highlights").setup()
require("config.keymaps")
require("config.autocmds")
require("config.basic_gui").setup()
require("config.user_commands").setup()
require("config.swap_words").setup()
require("config.floating-term")

Snacks.notify("Hello Rinav  ");

vim.opt.termguicolors = true
vim.keymap.del("", "<Tab>")

-- require('transparent').clear_prefix('Telescope')
-- require('transparent').clear_prefix('WhichKey')

vim.api.nvim_set_hl(0, "TabLineFill", { link ="Normal" })
vim.api.nvim_set_hl(0, "TabLine"    , { link = "Normal" })
vim.cmd([[
  cnoreabbrev <expr> lua getcmdtype() == ':' && getcmdline() == 'lua' ? '󰢱 ' : 'lua'
]])
