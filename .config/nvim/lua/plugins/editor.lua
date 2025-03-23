return {
  -- Hihglight colors
  {
    "echasnovski/mini.hipatterns",
    event = "BufReadPre",
    opts = {},
  },
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
        names_custom = false,                   -- Custom names to be highlighted: table|function|false|nil
        RGB = true,                             -- #RGB hex codes
        RRGGBB = true,                          -- #RRGGBB hex codes
        RRGGBBAA = false,                       -- #RRGGBBAA hex codes
        AARRGGBB = false,                       -- 0xAARRGGBB hex codes
        rgb_fn = false,                         -- CSS rgb() and rgba() functions
        hsl_fn = false,                         -- CSS hsl() and hsla() functions
        css = false,                            -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false,                         -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Highlighting mode.  'background'|'foreground'|'virtualtext'
        mode = "background",                    -- Set the display mode
        -- Tailwind colors.  boolean|'normal'|'lsp'|'both'.  True is same as normal
        tailwind = true,                        -- Enable tailwind colors
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
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    priority = 1000,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim",  build = "make" },
      { "nvim-telescope/telescope-file-browser.nvim" },
      { 'nvim-telescope/telescope-media-files.nvim' }
    },
    keys = {
      {
        "<leader><leader>",
        function()
          local builtin = require("telescope.builtin")
          builtin.find_files(require("telescope.themes").get_ivy({}))
        end,
        desc = "Lists files in your current working directory, respects .gitignore",
      },
      {
        "<leader>tf",
        function()
          local builtin = require("telescope.builtin")
          builtin.find_files(require("telescope.themes").get_ivy({}))
        end,
        desc = "Lists files in your current working directory, respects .gitignore",
      },
      {
        "<leader>tw",
        function()
          local builtin = require("telescope.builtin")
          local word = vim.fn.expand("<cword>")
          builtin.grep_string(require("telescope.themes").get_ivy({ search = word }))
        end,
        desc = "Lists files in your current working directory, respects .gitignore",
      },
      {
        "<leader>tW",
        function()
          local builtin = require("telescope.builtin")
          local word = vim.fn.expand("<cWORD>")
          builtin.grep_string(require("telescope.themes").get_ivy({ search = word }))
        end,
        desc = "Lists files in your current working directory, respects .gitignore",
      },
      {
        "<leader>th",
        function()
          local builtin = require("telescope.builtin")
          builtin.help_tags(require("telescope.themes").get_ivy({}))
        end,
        desc = "Help tags",
      },
      {
        "<leader>tg",
        function()
          local opts = require("telescope.themes").get_ivy({})
          local builtin = require("telescope.builtin")
          builtin.live_grep(opts)
        end,
        desc =
          "Search for a string in your current working directory and get results live as you type, respects .gitignore",
      },
      {
        "<leader>uC",
        function()
          local opts = require("telescope.themes").get_ivy({})
          local builtin = require("telescope.builtin")
          builtin.colorscheme(opts)
        end,
        desc =
          "Try available colorschemes",
      },
      {
        "<leader>tt",
        function()
          local builtin = require("telescope.builtin")
          builtin.resume()
        end,
        desc = "Resume the previous telescope picker",
      },
      {
        "<leader>te",
        function()
          local opts = require("telescope.themes").get_ivy({
            layout_config = { height = 14 },
          })
          local builtin = require("telescope.builtin")
          builtin.diagnostics(opts)
        end,
        desc = "Lists Diagnostics for all open buffers or a specific buffer",
      },
      {
        "<leader>ts",
        function()
          local builtin = require("telescope.builtin")
          builtin.treesitter(require("telescope.themes").get_ivy({}))
        end,
        desc = "Lists Function names, variables, from Treesitter",
      },
      {
        "<leader>tr",
        function()
          local builtin = require("telescope.builtin")
          builtin.registers()
        end,
        desc = "Browse the registers",
      },
      {
        "<leader>tb",
        function()
          local builtin = require("telescope.builtin")
          builtin.buffers(require("telescope.themes").get_ivy({
            show_mru = true,
            ignore_current_buffer = true,
          }))
        end,
        desc = "List open buffers with diagnostics, flags, and line count",
      }
    },
    opts = {
      defaults = {
        wrap_results = true,
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "bottom" },
        sorting_strategy = "descending",
        winblend = 0,
        mappings = {
          n = {},
        },
      },
      pickers = {
        colorscheme = {
          enable_preview = true
        },
        diagnostics = {
          theme = "ivy",
          initial_mode = "normal",
          layout_config = {
            preview_cutoff = 9999,
          },
        },
      },
      extensions = {
        media_files = {
          -- filetypes whitelist
          -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
          filetypes = { "png", "webp", "jpg", "jpeg" },
          -- find command (defaults to `fd`)
          find_cmd = "rg",
          use_terminal = "true"
        }
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")

      -- Setup telescope
      telescope.setup(opts)

      -- Load extensions
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
      telescope.load_extension("media_files")
    end,
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
    --dependencies = { { "echasnovski/mini.icons", opts = {} } },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      -- A list of parser names, or "all" (supported parsers)
      ensure_installed = {
        "bash", "c", "html", "javascript", "json", "lua", "markdown", "python", "regex", "rust", "tsx",
        "typescript",
        "vim", "yaml",
      },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      auto_install = true,

      highlight = {
        -- Enable syntax highlighting
        enable = true,

        -- Disable slow treesitter highlight for large files
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        additional_vim_regex_highlighting = false,
      },

      indent = { enable = true },

      fold = {
        enable = true,
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = false, -- Unset default if needed
          node_incremental = false, -- Unset default if needed
          scope_incremental = false,
          node_decremental = false,
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      local ts_selection = require("nvim-treesitter.incremental_selection")

      -- Keymaps with descriptions
      vim.keymap.set("n", "gnn", ts_selection.init_selection, {
        noremap = true,
        silent = true,
        desc = "[TS] Start incremental selection (selects the node under cursor)",
      })

      vim.keymap.set("n", "gnr", ts_selection.node_incremental, {
        noremap = true,
        silent = true,
        desc = "[TS] Expand selection to the next larger node",
      })

      vim.keymap.set("n", "gnc", ts_selection.scope_incremental, {
        noremap = true,
        silent = true,
        desc = "[TS] Expand selection to the next larger syntax scope (e.g., function, loop, etc.)",
      })

      vim.keymap.set("n", "gnm", ts_selection.node_decremental, {
        noremap = true,
        silent = true,
        desc = "[TS] Shrink selection to the previous smaller node",
      })
    end,
  },
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
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = false,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom", -- | top | left | right | horizontal | vertical
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = false,
          auto_trigger = false,
          hide_during_completion = true,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = true,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        copilot_node_command = "node", -- Node.js version must be > 18.x
        server_opts_overrides = {},
      })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken",                      -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
  { "AndreM222/copilot-lualine" },
  {
    'anuvyklack/hydra.nvim',
    config = function()
      local Hydra = require('hydra')
      Hydra({
        name = 'Quickfix List',
        mode = 'n', -- Normal mode
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
