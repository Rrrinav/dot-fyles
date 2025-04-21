return
{
  {
    "giuxtaposition/blink-cmp-copilot"
  },
  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      snippets = {
        preset = 'luasnip'
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 400,
          window = {
            border = "rounded",
            winhighlight = "FloatBorder:FloatBorder"
          },
        },
        keyword = { range = "full" },
        list = { selection = { preselect = true, auto_insert = false } },
        menu = {
          -- border = "rounded",
          winhighlight = "FloatBorder:FloatBorder",
          draw = {
            columns = {
              { "kind_icon",         "label", gap = 1 },
              { "label_description", "kind",  gap = 1 }
            },
            -- treesitter = { "lsp" }
          }
        },
        ghost_text = {
          enabled = true,
        },
      },
      sources = {
        default = { "snippets", "lsp", "path", "buffer", "copilot" }, -- Changed from default to enabled, removed luasnip
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 100,
            async = true,
            transform_items = function(_, items)
              local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
              local kind_idx = #CompletionItemKind + 1
              CompletionItemKind[kind_idx] = "Copilot"
              for _, item in ipairs(items) do
                item.kind = kind_idx
              end
              return items
            end,
          },
        },
      },
      signature = {
        enabled = true,
        window = { border = "single" }
      },
      appearance = {
        kind_icons = require('../icons').autocomplete,
      },
      keymap = {
        preset = 'none',
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>']     = { 'hide', 'fallback' },
        ['<CR>']      = { 'accept', 'fallback' },
        ['<C-y>']     = { 'accept', 'fallback' },
        ['<Up>']      = { 'select_prev', 'fallback' },
        ['<Down>']    = { 'select_next', 'fallback' },
        ['<C-p>']     = { 'select_prev', 'fallback' },
        ['<C-n>']     = { 'select_next', 'fallback' },
        ['<C-b>']     = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>']     = { 'scroll_documentation_down', 'fallback' },
      },
      cmdline = {
      }
    },
  },
  {
    'echasnovski/mini.align',
    version = '*',
    opts = {
      mappings = {
        start = 'ma',
        start_with_preview = 'mA',
      },

      -- Modifiers changing alignment steps and/or options
      --   modifiers = {
      --     -- Main option modifiers
      --     ['s'] = --<function: enter split pattern>,
      --       ['j'] = --<function: choose justify side>,
      --       ['m'] = --<function: enter merge delimiter>,
      --
      --       -- Modifiers adding pre-steps
      --       ['f'] = --<function: filter parts by entering Lua expression>,
      --       ['i'] = --<function: ignore some split matches>,
      --       ['p'] = --<function: pair parts>,
      --       ['t'] = --<function: trim parts>,
      --
      --       -- Delete some last pre-step
      --       ['<BS>'] = --<function: delete some last pre-step>,
      --
      --       -- Special configurations for common splits
      --       ['='] = --<function: enhanced setup for '='>,
      --       [','] = --<function: enhanced setup for ','>,
      --       ['|'] = --<function: enhanced setup for '|'>,
      --       [' '] = --<function: enhanced setup for ' '>,
      --   },
      --
      --   -- Default options controlling alignment process
      --   options = {
      --     split_pattern = '',
      --     justify_side = 'left',
      --     merge_delimiter = '',
      --   },
      --
      --   -- Default steps performing alignment (if `nil`, default is used)
      --   steps = {
      --     pre_split = {},
      --     split = nil,
      --     pre_justify = {},
      --     justify = nil,
      --     pre_merge = {},
      --     merge = nil,
      --   },
      --
      --   -- Whether to disable showing non-error feedback
      --   -- This also affects (purely informational) helper messages shown after
      --   -- idle time if user input is required.
      --   silent = false,
      -- }
    }
  },
  {
    "3rd/image.nvim",
    dependencies = { "luarocks.nvim" },
    opts = {
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = true,
          filetypes = { "markdown", "vimwiki" },
        },
        neorg = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "norg" },
        },
        html = {
          enabled = false,
        },
        css = {
          enabled = false,
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      window_overlap_clear_enabled = false,                                               -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      editor_only_render_when_focused = false,                                            -- auto show/hide images when the editor gains/looses focus
      tmux_show_only_in_active_window = false,                                            -- auto show/hide images in the correct Tmux window (needs visual-activity off)
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
    },
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    config = true,
  },
  {
    "ej-shafran/compile-mode.nvim",
    -- you can just use the latest version:
    branch = "latest",
    -- or the most up-to-date updates:
    -- branch = "nightly",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- if you want to enable coloring of ANSI escape codes in
      -- compilation output, add:
      { "m00qek/baleia.nvim", tag = "v1.3.0" },
    },
    config = function()
      ---@type CompileModeOpts
      vim.g.compile_mode = {
        -- to add ANSI escape code support, add:
        baleia_setup = true,
        --debug = true,
      }
      require("compile-mode.config.internal").default_command = ""
    end,
  },
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle",                       -- optional for lazy loading on command
    event = { "InsertLeave" },              -- optional for lazy loading on trigger events
    opts = {
      trigger_events = {                    -- See :h events
        immediate_save = { "InsertLeave" }, -- vim events that trigger an immediate save
        defer_save = { "InsertLeave" },     -- vim events that trigger a deferred save (saves after `debounce_delay`)
      },                                    -- your config goes here
      -- or just leave it empty :)
    },
  },
  {
    'echasnovski/mini.surround',
    version = '*',
    opts = {
      -- Add custom surroundings to be used on top of builtin ones. For more
      -- information with examples, see `:h MiniSurround.config`.
      custom_surroundings = nil,

      -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
      highlight_duration = 500,

      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        add = '<leader>msa',            -- Add surrounding in Normal and Visual modes
        delete = '<leader>msd',         -- Delete surrounding
        find = '<leader>msf',           -- Find surrounding (to the right)
        find_left = '<leader>msF',      -- Find surrounding (to the left)
        highlight = '<leader>msh',      -- Highlight surrounding
        replace = '<leader>msr',        -- Replace surrounding
        update_n_lines = '<leader>msn', -- Update `n_lines`

        suffix_last = 'l',              -- Suffix to search with "prev" method
        suffix_next = 'n',              -- Suffix to search with "next" method
      },

      -- Number of lines within which surrounding is searched
      n_lines = 20,

      -- Whether to respect selection type:
      -- - Place surroundings on separate lines in linewise mode.
      -- - Place surroundings on each line in blockwise mode.
      respect_selection_type = false,

      -- How to search for surrounding (first inside current line, then inside
      -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
      -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
      -- see `:h MiniSurround.config`.
      search_method = 'cover',

      -- Whether to disable showing non-error feedback
      -- This also affects (purely informational) helper messages shown after
      -- idle time if user input is required.
      silent = false,
    }
  },
  {
    'MagicDuck/grug-far.nvim',
    config = function()
      require('grug-far').setup({
      });
    end
  },
  {
    "voxelprismatic/rabbit.nvim",
    config = function()
      require("rabbit").setup({
      })
    end,
  }
}
