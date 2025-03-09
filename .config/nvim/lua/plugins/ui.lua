return {
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
        { "<leader>ma", group = "Mini Align", icon = '󱀧 ' },
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
      -- Define icons manually
      local icons = {
        diagnostics = {
          Error = " ",
          Warn = " ",
          Info = " ",
          Hint = " ",
        },
        git = {
          added = " ",
          modified = " ",
          removed = " ",
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
          component_separators = { left = '', right = '' },
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
            { "progress", separator = " ",                  padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
            { "copilot" },
          },
          lualine_z = {
            function()
              return " " .. os.date("%R")
            end,
          },
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
    "rose-pine/neovim",
    config = function()
      vim.g.rose_pine_variant = "main"
    end,
  },
  {
      "pmouraguedes/neodarcula.nvim",
      lazy = false,
      priority = 1000,
  },
  {
    "EdenEast/nightfox.nvim",
    opts = {
      options = {
        styles = {
          comments = "italic",
          -- keywords = "none",
          types = "italic,bold",
          strings = "italic",
        }
      }
    }
  },
  {
    "gbprod/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nord").setup({})
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true
  },
  {
    "sainnhe/sonokai",
    config = function()
      vim.g.sonokai_enable_italic = true
      vim.g.sonokai_style = 'atlantis'
      vim.g.sonokai_enable_italic = true
      vim.g.sonokai_better_performance = 1
    end,
  },
  {
    'navarasu/onedark.nvim',
    opts = {
      highlights = {
        CursorLine = { bg = '#41454f' }, -- Fixed: String key instead of a variable
      },
      code_style = {
        comments = 'italic',
        keywords = 'italic',
        functions = 'none',
        strings = 'italic',
        variables = 'none'
      },
    },
  },
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
}
