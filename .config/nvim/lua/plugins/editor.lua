return {
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = { -- set to setup table
      filetypes = { "*" },
      user_default_options = {
        names = false, -- "Name" codes like Blue or blue
        -- Expects a table of color name to rgb value pairs.  # is optional
        -- Example: { cool = "#107dac", ["notcool"] = "ee9240" }
        -- Set to false|nil to disable
        names_custom = false,                           -- Custom names to be highlighted: table|function|false|nil
        RGB = true,                                     -- #RGB hex codes
        RRGGBB = true,                                  -- #RRGGBB hex codes
        RRGGBBAA = false,                               -- #RRGGBBAA hex codes
        AARRGGBB = false,                               -- 0xAARRGGBB hex codes
        rgb_fn = false,                                 -- CSS rgb() and rgba() functions
        hsl_fn = false,                                 -- CSS hsl() and hsla() functions
        css = false,                                    -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false,                                 -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Highlighting mode.  'background'|'foreground'|'virtualtext'
        mode = "background",                            -- Set the display mode
        -- Tailwind colors.  boolean|'normal'|'lsp'|'both'.  True is same as normal
        tailwind = true,                                -- Enable tailwind colors
        -- parsers can contain values used in |user_default_options|
        sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
        -- Virtualtext character to use
        virtualtext = "■",
        -- Display virtualtext inline with color
        virtualtext_inline = false,
        -- Virtualtext highlight mode: 'background'|'foreground'
        virtualtext_mode = "foreground",
        -- update color values even if buffer is not focused
        -- example use: cmp_menu, cmp_docs
        always_update = false,
      },
      -- all the sub-options of filetypes apply to buftypes
      buftypes = {},
      -- Boolean | List of usercommands to enable
      user_commands = true, -- Enable all or some usercommands
    },
  },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts

    opts = {
      default_file_explorer = true,
      columns = {
        "icon",
        "permissions",
        "size",
        -- "mtime",
      },

      delete_to_trash = true,
      watch_for_changes = true,
      keymaps = {
        ["q"] = { "actions.close", mode = "n" },
      },
      view_options = {
        is_hidden_file = function(name, bufnr)
          if name == ".env" or name == ".gitignore" then
            return false
          end
          local m = name:match("^%.")
          return m ~= nil
        end,
      },
      float = {
        -- Padding around the floating window
        padding = 4,
        -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        max_width = 0,
        max_height = 0,
        border = "rounded",
        win_options = {
          winblend = 10,
        },
        -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
        get_win_title = nil,
        -- preview_split: Split direction: "auto", "left", "right", "above", "below".
        preview_split = "auto",
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        override = function(conf)
          return conf
        end,
      },
    },

    -- Optional dependencies
    -- dependencies = {  },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },
  { "echasnovski/mini.icons",                     opts = {} },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    'anuvyklack/hydra.nvim',
    config = function()
      local Hydra = require('hydra')
      Hydra({
        name = 'Quickfix List',
        mode = 'n',         -- Normal mode
        body = '<leader>q', -- Trigger for the hydra
        heads = {
          { 'n', ':cnext<CR>',  { desc = 'Next Item' } },
          { 'p', ':cprev<CR>',  { desc = 'Previous Item' } },
          { 'o', ':copen<CR>',  { desc = 'Open Quickfix List' } },
          { 'c', ':cclose<CR>', { desc = 'Close Quickfix List' } },
          { 'O', ':colder<CR>', { desc = 'Older Quickfix List' } },
          { 'N', ':cnewer<CR>', { desc = 'Newer Quickfix List' } },
          { 'q', nil,           { exit = true, desc = 'Exit Hydra' } },
        },
      })
      Hydra({
        name = 'Window Management',
        mode = 'n',
        body = '<leader>w',
        heads = {
          { '<left>',  '<C-w>>',     { desc = 'Manage dimensions' } },
          { '<right>', '<C-w><',     { desc = 'Manage dimensions' } },
          { '<up>',    '<C-w>-',     { desc = 'Manage dimensions' } },
          { '<down>',  '<C-w>+',     { desc = 'Manage dimensions' } },
          { '=',       '<C-w>=',     { desc = 'Equalize size' } },
          { 'x',       ':close<CR>', { exit = true, desc = 'Exit Hydra' } },
        },
      })
    end
  }
}
