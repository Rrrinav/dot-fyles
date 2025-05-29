local copilot = require "copilot.api"
return {
  { 'AndreM222/copilot-lualine' },
  {
    "j-hui/fidget.nvim",
    opts = {
      -- options
    },
  },
  {
    "xiyaowong/transparent.nvim",
    opts = {
      extra_groups = {
        "NormalFloat",    -- plugins which have float panel such as Lazy, Mason, LspInfo
        "NvimTreeNormal", -- NvimTree
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      preset = "helix",
      spec = {
        { "<leader>t", group = "Telescope plugins" },
        { "<leader>m", group = "Mini Plugins", icon = '󱀧 ' },
        { "<leader>ms", group = "Mini Surround", icon = '󱀧 ' },
        { "<leader>b", group = "Buffer management" },
        { "<leader>w", group = "Window management" },
        { "<leader>u", group = "UI" },
        { "<leader>c", group = "Code" },
        { "<leader>g", group = "Git" },
        { "gb", group = "Lsp go tos but in different buffer", icon = "󰩗" },
        { "<leader>x", group = "Diagnotics", icon = "" },
        { "<leader>q", group = "Quickfix List & Session Management" },
        { "<leader><Tab>", group = "Tabs (key = tab)" },
        { "<leader><Tab>m", group = "Move tab" },
        { "<leader>f", group = "Terminal / file" }
      },
    },
  },
  {
    'b0o/incline.nvim',
    config = function()
      require('incline').setup()
    end,
    -- Optional: Lazy load Incline
    event = 'VeryLazy',
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
    end,
    opts = function()
      require("lualine").setup({
        sections = {
          lualine_x = {
            "encoding", "fileformat", "filetype"
          },
        }
      })
      -- Define icons manually
      local icons = {
        diagnostics = {
          Error = " ",
          Warn = " ",
          Info = " ",
          Hint = " ",
        },
        git = {
          added = "+", --  ",
          modified = "~", -- " " 
          removed = "-" -- " ",
        },
      }

      -- Function to trim path relative to CWD
      local function trimmed_path()
        local full_path = vim.fn.expand("%:p") -- Full file path
        local cwd = vim.fn.getcwd() -- Get current working directory
        return " " .. vim.fn.fnamemodify(full_path, ":~:.") -- Show relative path
      end

      -- Ensure `laststatus` is restored globally
      vim.o.laststatus = vim.g.lualine_laststatus

      local opts = {
        globalstatus = true, -- Force global statusline
        options = {
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
          section_separators = { left = '', right = '' },
       -- component_separators = { left = '', right = '' },
          component_separators = { left = '│', right = '│' },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            {
              "filetype",
              icon_only = true,
              separator = "",
              padding = { left = 1, right = 0 },
            },
            {
              trimmed_path, -- Show relative path from CWD
            },
          },
          lualine_x = {
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function() return { fg = "#fab387" } end, -- Set a custom color
            },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          lualine_y = {
            {
              function()
                local excluded_clients = { ["null-ls"] = true, ["copilot"] = true }
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if #clients == 0 then
                  return ""
                end
                local names = {}
                for _, client in pairs(clients) do
                  if not excluded_clients[client.name] then
                    table.insert(names, client.name)
                  end
                end
                if #names == 0 then
                  return ""
                end
                return "LSP: " .. table.concat(names, ", ")
              end,
              icon = "",
            },
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            -- { "location", padding = { left = 0, right = 1 } },
            { 'copilot' },
          },
          -- lualine_z = {
          --   function()
          --     return " " .. os.date("%R")
          --   end,
          -- },
        },
        extensions = { "neo-tree", "lazy", "fzf" },
      }

      -- Add support for trouble.nvim (if installed)
      if vim.g.trouble_lualine and pcall(require, "trouble") then
        local trouble = require("trouble")
        local symbols = trouble.statusline({
          mode = "symbols",
          groups = {},
          title = false,
          filter = { range = true },
          format = "{kind_icon}{symbol.name:Normal}",
          hl_group = "lualine_c_normal",
        })
        table.insert(opts.sections.lualine_c, {
          symbols and symbols.get,
          cond = function()
            return vim.b.trouble_lualine ~= false and symbols.has()
          end,
        })
      end

      return opts
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    opts = {
      options = {
        styles = {
          comments = nil,
          keywords = nil,
          types = nil,
          strings = nil,
        }
      }
    }
  },
  {
    "thesimonho/kanagawa-paper.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      styles = {
        -- style for comments
        comment = { italic = false },
        -- style for functions
        functions = { italic = false },
        -- style for keywords
        keyword = { italic = false, bold = false },
        -- style for statements
        statement = { italic = false, bold = false },
        -- style for types
        type = { italic = false },
      },
      colors ={
        theme = {
          ink = { ui = { bg = "#18181f" }}
        }
      }
    },
  },
  {
    "gbprod/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nord").setup({
        transparent = false,        -- Enable this to disable setting the background color
        terminal_colors = true,     -- Configure the colors used when opening a `:terminal` in Neovim
        diff = { mode = "bg" },     -- enables/disables colorful backgrounds when used in diff mode. values : [bg|fg]
        borders = true,             -- Enable the border between verticaly split windows visible
        errors = { mode = "bg" },   -- Display mode for errors and diagnostics
        -- values : [bg|fg|none]
        search = { theme = "vim" }, -- theme for highlighting search results
        -- values : [vim|vscode]
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
        },

        -- Override the default colors
        ---@param colors Nord.Palette
        on_colors = function(colors) end,

        --- You can override specific highlights to use other groups or a hex color
        --- function will be called with all highlights and the colorScheme table
        ---@param colors Nord.Palette
        on_highlights = function(highlights, colors) end,
      })
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true
  },
  {
    'mellow-theme/mellow.nvim',
    config = function()
      vim.g.mellow_italic_comments     = false;
      vim.g.mellow_italic_keywords     = false;
      vim.g.mellow_italic_booleans     = false;
      vim.g.mellow_italic_functions    = false;
      vim.g.mellow_italic_variables    = false;
      vim.g.mellow_italic_namespaces   = false;
      vim.g.mellow_highlight_overrides = {
        ["Type"] = { fg = "#A383D6" },
        ["Function"] = { fg = "#96ebc3" }
      }
    end
  },
  { 'Mofiqul/dracula.nvim' },
  {
    "sainnhe/sonokai",
    config = function()
      -- vim.g.sonokai_enable_italic = true
      -- vim.g.sonokai_style = 'atlantis'
      -- vim.g.sonokai_enable_italic = true
      -- vim.g.sonokai_better_performance = 1
    end,
  },
  {
    'navarasu/onedark.nvim',
    opts = {
      highlights = {
        CursorLine = { bg = '#41454f' }, -- Fixed: String key instead of a variable
      },
      code_style = {
        comments = 'none',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
      },
    },
  }, -- Using lazy.nvim
  {
    'nanozuki/tabby.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      local theme = {
        fill = 'TabLineFill',
        -- head = { fg = '#94e2d5', bg = bg},
        head = 'TabLine',
        current_tab = { fg = '#fadafa', bg = '#45475a', style = "bold" },
        tab = { fg = '#74c7ec', bg = '#313244' },
        win = { fg = '#a6e3a1', bg = '#1a1e2e' },
        tail = { fg = '#94e2d5', bg = '#181825' },
      }


      -- Helper functions for tab information
      local function get_win_count(tabid)
        local wins = require('tabby.module.api').get_tab_wins(tabid)
        local count = #wins
        return count == 1 and "" or string.format("[%d]", count)
      end

      local function check_modified(tabid)
        local wins = require('tabby.module.api').get_tab_wins(tabid)
        for _, win in ipairs(wins) do
          local buf = require('tabby.module.api').get_win_buf(win)
          if require('tabby.module.api').get_buf_is_changed(buf) then
            return "󰚕 "
          end
        end
        return ""
      end

      local function check_buf_modified(buf)
        if buf.is_changed() then
          return "󰚕 "
        end
        return ""
      end

      local function get_win_logo(win)
        if win.is_current() then
          return " "
        else
          return " "
        end
      end

      local get_buf_count = function()
        local bufs = require('tabby.module.api').get_bufs()
        return #bufs
      end

      -- Setup tabby configuration
      require('tabby').setup({
        line = function(line)
          return {
            -- Header section
            {
              { ' ', hl = theme.head },
              { ' ', hl = theme.head }, -- vim logo
              { '', hl = theme.head }, -- separator after logo
              line.sep('', theme.head, theme.head),
            },
            -- Tabs section
            line.tabs().foreach(function(tab)
              local hl = tab.is_current() and theme.current_tab or theme.tab
              return {
                line.sep('', hl, theme.fill),
                tab.is_current() and '󰆤 ' or '󰆣 ',
                tab.number(),
                -- ':',
                -- tab.name(),
                get_win_count(tab.id),
                check_modified(tab.id),
                tab.close_btn(''),
                line.sep('', hl, theme.fill),
                hl = hl,
                margin = ' ',
              }
            end), -- Spacer
            line.spacer(),
            -- Windows in current tab section
            line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
              return {
                line.sep('', theme.win, theme.fill),
                check_buf_modified(win.buf()),
                win.is_current() and '' or '',
                win.buf_name(),
                get_win_logo(win),
                line.sep('', theme.win, theme.fill),
                hl = theme.win,
                margin = ' ',
              }
            end),
            -- Tail section
            {
              line.sep('', theme.tail, theme.fill),
              { get_buf_count(), hl = theme.tail },
              { ' ', hl = theme.tail },
              { ' ', hl = theme.tail },
            },
            hl = theme.fill,
          }
        end,
        opts = {
          tab_name = {
            name_fallback = function(tabid)
              local wins = get_win_count(tabid)
              local changed = check_modified(tabid)
              return string.format("%s%s", wins, changed)
            end
          },
          buf_name = {
            mode = "unique"
          }
        }
      })

      -- Set Neovim options
      vim.opt.termguicolors = true
      vim.opt.showtabline = 2

      -- Key mappings
      local map_opts = { noremap = true }
      local mappings = {
        ["<leader><Tab>a"] = { cmd = ":$tabnew<CR>", desc = "New tab" },
        ["<leader><Tab><Tab>"] = { cmd = ":$tabnew<CR>", desc = "New tab" },
        ["<leader><Tab>c"] = { cmd = ":tabclose<CR>", desc = "Close tab" },
        ["<leader><Tab>o"] = { cmd = ":tabonly<CR>", desc = "Close other tabs" },
        ["<leader><Tab>n"] = { cmd = ":tabn<CR>", desc = "Next tab" },
        ["<leader><Tab>p"] = { cmd = ":tabp<CR>", desc = "Previous tab" },
        ["]t"] = { cmd = ":tabn<CR>", desc = "Next tab" },
        ["[t"] = { cmd = ":tabp<CR>", desc = "Previous tab" },
        ["<leader><Tab>mp"] = { cmd = ":-tabmove<CR>", desc = "Move tab back" },
        ["<leader><Tab>mn"] = { cmd = ":+tabmove<CR>", desc = "Move tab forward" },
      }

      for k, v in pairs(mappings) do
        vim.api.nvim_set_keymap("n", k, v.cmd, { noremap = true, desc = v.desc })
      end
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { text = "│" }, -- Thin vertical bar
          change = { text = "│" }, -- Same as add for consistency
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "┆" },
          untracked = { text = "┆" }, -- Dotted vertical bar
        },
        signs_staged = {
          add = { text = "┃" }, -- Bold vertical bar
          change = { text = "┃" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "┃" },
        },
        signs_staged_enable = true, -- Enable staged signs
        signcolumn = true,          -- Toggle with `:Gitsigns toggle_signs`
        numhl = false,              -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false,             -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false,          -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          follow_files = true
        }, on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")
      end,
        auto_attach                  = true,
        attach_to_untracked          = false,
        current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts      = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
          use_focus = true,
        },
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        sign_priority                = 6,
        update_debounce              = 100,
        status_formatter             = nil,   -- Use default
        max_file_length              = 40000, -- Disable if file is longer than this (in lines)
        preview_config               = {
          -- Options passed to nvim_open_win
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 3
        },
      }
    end
  },
  {
    "sphamba/smear-cursor.nvim",
    opts = {
      -- Smear cursor when switching buffers or windows.
      smear_between_buffers = true,

      -- Smear cursor when moving within line or to neighbor lines.
      -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
      smear_between_neighbor_lines = true,

      -- Draw the smear in buffer space instead of screen space when scrolling
      scroll_buffer_space = true,

      -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
      -- Smears will blend better on all backgrounds.
      legacy_computing_symbols_support = false,

      -- Smear cursor in insert mode.
      -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
      smear_insert_mode = true,
      stiffness = 0.5,
      trailing_stiffness = 0.4,
    }
  },
  {
    'stevearc/dressing.nvim',
    opts = {
      input = {
        -- Set to false to disable the vim.ui.input implementation
        enabled = false,

        -- Default prompt string
        default_prompt = "Input",

        -- Trim trailing `:` from prompt
        trim_prompt = true,

        -- Can be 'left', 'right', or 'center'
        title_pos = "left",

        -- The initial mode when the window opens (insert|normal|visual|select).
        start_mode = "insert",

        -- These are passed to nvim_open_win
        border = "rounded",
        -- 'editor' and 'win' will default to being centered
        relative = "cursor",

        -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        prefer_width = 40,
        width = nil,
        -- min_width and max_width can be a list of mixed types.
        -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
        max_width = { 140, 0.9 },
        min_width = { 20, 0.2 },

        buf_options = {},
        win_options = {
          -- Disable line wrapping
          wrap = false,
          -- Indicator for when text exceeds window
          list = true,
          listchars = "precedes:…,extends:…",
          -- Increase this for more context when text scrolls off the window
          sidescrolloff = 0,
        },

        -- Set to `false` to disable
        mappings = {
          n = {
            ["<Esc>"] = "Close",
            ["<CR>"] = "Confirm",
          },
          i = {
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
            ["<Up>"] = "HistoryPrev",
            ["<Down>"] = "HistoryNext",
          },
        },

        override = function(conf)
          -- This is the config that will be passed to nvim_open_win.
          -- Change values here to customize the layout
          return conf
        end,

        -- see :help dressing_get_config
        get_config = nil,
      },
      select = {
        -- Set to false to disable the vim.ui.select implementation
        enabled = true,

        -- Priority list of preferred vim.select implementations
        backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },

        -- Trim trailing `:` from prompt
        trim_prompt = true,

        -- Options for telescope selector
        -- These are passed into the telescope picker directly. Can be used like:
        -- telescope = require('telescope.themes').get_ivy({...})
        telescope = require('telescope.themes').get_ivy({...}),

        -- Options for fzf selector
        fzf = {
          window = {
            width = 0.5,
            height = 0.4,
          },
        },

        -- Options for fzf-lua
        fzf_lua = {
          -- winopts = {
          --   height = 0.5,
          --   width = 0.5,
          -- },
        },

        -- Options for nui Menu
        nui = {
          position = "50%",
          size = nil,
          relative = "editor",
          border = {
            style = "rounded",
          },
          buf_options = {
            swapfile = false,
            filetype = "DressingSelect",
          },
          win_options = {
            winblend = 0,
          },
          max_width = 80,
          max_height = 40,
          min_width = 40,
          min_height = 10,
        },

        -- Options for built-in selector
        builtin = {
          -- Display numbers for options and set up keymaps
          show_numbers = true,
          -- These are passed to nvim_open_win
          border = "rounded",
          -- 'editor' and 'win' will default to being centered
          relative = "editor",

          buf_options = {},
          win_options = {
            cursorline = true,
            cursorlineopt = "both",
            -- disable highlighting for the brackets around the numbers
            winhighlight = "MatchParen:",
            -- adds padding at the left border
            statuscolumn = " ",
          },

          -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          -- the min_ and max_ options can be a list of mixed types.
          -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
          width = nil,
          max_width = { 140, 0.8 },
          min_width = { 40, 0.2 },
          height = nil,
          max_height = 0.9,
          min_height = { 10, 0.2 },

          -- Set to `false` to disable
          mappings = {
            ["<Esc>"] = "Close",
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
          },

          override = function(conf)
            -- This is the config that will be passed to nvim_open_win.
            -- Change values here to customize the layout
            return conf
          end,
        },

        -- Used to override format_item. See :help dressing-format
        format_item_override = {},

        -- see :help dressing_get_config
        get_config = nil,
      },
    },
  }
}
