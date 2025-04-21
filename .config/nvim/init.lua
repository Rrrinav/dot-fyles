require("config.lazy")

vim.cmd.colorscheme("nightfox")
require("config.essential_highlights")
require("config.highlights").setup()
require("config.req_highlights") -- Don't remove
require("config.keymaps")
require("config.autocmds")
require("config.basic_gui").setup()
require("config.user_commands").setup()
require("config.swap_words").setup()
require("config.floating-term")

Snacks.notify("Hello Rinav  ");

vim.opt_local.indentkeys:remove(":")
vim.opt.termguicolors = true
vim.keymap.del("", "<Tab>")

-- require('transparent').clear_prefix('Telescope')
-- require('transparent').clear_prefix('WhichKey')
-- require('transparent').clear_prefix('Oil')

vim.api.nvim_set_hl(0, "TabLineFill", { link = "Normal" })
vim.api.nvim_set_hl(0, "TabLine"    , { link = "Normal" })
