return {
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
        default = { "snippets", "lsp", "path", "buffer", "copilot", "omni" }, -- Changed from default to enabled, removed luasnip
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
        preset        = 'none',
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>']     = { 'hide', 'fallback' },
        ['<CR>']      = { 'accept','fallback' },
        ['<C-y>']     = { 'accept', 'fallback' },
        ['<Up>']      = { 'select_prev', 'fallback' },
        ['<Down>']    = { 'select_next', 'fallback' },
        ['<C-p>']     = { 'select_prev', 'fallback' },
        ['<C-n>']     = { 'select_next', 'fallback' },
        ['<C-b>']     = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>']     = { 'scroll_documentation_down', 'fallback' },
        ['<Tab>']     = { 'snippet_forward', 'select_next', 'fallback' },
        ['<S-Tab>']   = { 'snippet_backward', 'select_prev',  'fallback' },
      },
      cmdline = {
      }
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
    build = "make tiktoken",                          -- Only on MacOS or Linux
    opts = {
    },
  },
}
