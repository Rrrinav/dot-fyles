require("config.lazy")

vim.cmd.colorscheme("nightfox") -- Or any other theme
require("config.highlights").setup()

require("config.keymaps")
require("config.autocmds")
require("config.basic_gui").setup()
require("config.user_commands").setup()
require("config.swap_words").setup()
require("config.floating-term")

vim.opt.termguicolors = true
vim.keymap.del("", "<Tab>")

vim.api.nvim_set_hl(0, "TabLineFill", { link ="Normal" })
vim.api.nvim_set_hl(0, "TabLine",     { link = "Normal" })

-- vim.o.winbar = "%f %m" -- Show filename (%f) and modified flag (%m)
