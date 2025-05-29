return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      inlay_hints = { enabled = false },
    },
    dependencies = {
      {
        "mason.nvim" ,
        cmd = "Mason",
        build = ":MasonUpdate",
        opts = {
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        },
      },
      {
        "mason-lspconfig.nvim",
        opts = {
          ensure_installed = {},
          automatic_enable = {
            exclude = { "pylsp" }
          }
        },
        config = function ()
          if vim.loop.os_uname().sysname == "Windows_NT" then
          require("mason-lspconfig").setup({
            ensure_installed = {
              "clangd",
              "lua_ls",
              "pylsp",
              "rust_analyzer",
            },
            automatic_enable = {
              exclude = { "pylsp", "clangd" }
            }
          })
          end
          require("mason-lspconfig").setup({
            ensure_installed = {
              "clangd",
              "lua_ls",
              "pylsp",
              "rust_analyzer",
            },
            automatic_enable = {
              exclude = { "pylsp" }
            }
          })
        end
      },
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      -- vim.diagnostic.config({virtual_text = false})
      local lspconfig = require("lspconfig")
      -- LSP keybindings
      local function with_desc(description, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        if description then
          opts.desc = description
        end
        return opts
      end
      -- LSP Global Keymaps
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
      vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition()
        if #vim.fn.getqflist() == 1 then
          vim.cmd("cc 1")
        end
      end, { desc = "Go to definition" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line diagnostics" })
      vim.keymap.set("n", "gbD", function()
        vim.cmd("vsplit")
        vim.lsp.buf.declaration()
      end, { desc = "Go to declaration in vsplit" })
      vim.keymap.set("n", "gbd", function()
        vim.cmd("vsplit")
        vim.lsp.buf.definition()
        if #vim.fn.getqflist() == 1 then
          vim.cmd("cc 1")
        end
      end, { desc = "Go to definition in vsplit" })
      vim.keymap.set("n", "gbr", function()
        vim.cmd("vsplit")
        vim.lsp.buf.references()
      end, { desc = "Go to references in vsplit" })
      vim.keymap.set("n", "gbI", function()
        vim.cmd("vsplit")
        vim.lsp.buf.implementation()
      end, { desc = "Go to implementation in vsplit" })

      lspconfig.pylsp.setup({
        settings = {
          pylsp = {
            plugins = {
              pycodestyle = { enabled = false },  -- disable basic style checks
              pylint = { enabled = false },       -- disable pylint
              mccabe = { enabled = false },       -- disable complexity checker
              pyflakes = { enabled = false },     -- disable pyflakes
              jedi_completion = { include_params = true }, -- enable param info
            },
          },
        },
      })
      -- If windows change output executable type in clangd to .exe
      if vim.loop.os_uname().sysname == "Windows_NT" then
        lspconfig.clangd.setup({
          cmd = { "clangd", "--target=x86_64-pc-windows-msvc" },
          -- Add crash protection:
          on_attach = function(client, bufnr)
            client.server_capabilities.semanticTokensProvider = nil
          end
        })
      end
    end,
  },
  {
    "p00f/clangd_extensions.nvim"
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      link = {
        -- Turn on / off inline link icon rendering.
        enabled = true,
        -- Additional modes to render links.
        render_modes = true,
        -- How to handle footnote links, start with a '^'.
        footnote = {
          -- Turn on / off footnote rendering.
          enabled = true,
          -- Replace value with superscript equivalent.
          superscript = true,
          -- Added before link content.
          prefix = '',
          -- Added after link content.
          suffix = '',
        },
        -- Inlined with 'image' elements.
        image = '󰥶 ',
        -- Inlined with 'email_autolink' elements.
        email = '󰀓 ',
        -- Fallback icon for 'inline_link' and 'uri_autolink' elements.
        hyperlink = '󰌹 ',
        -- Applies to the inlined icon as a fallback.
        highlight = 'RenderMarkdownLink',
        -- Applies to WikiLink elements.
        wiki = {
          icon = '󱗖 ',
          body = function()
            return nil
          end,
          highlight = 'RenderMarkdownWikiLink',
        },
        -- Define custom destination patterns so icons can quickly inform you of what a link
        -- contains. Applies to 'inline_link', 'uri_autolink', and wikilink nodes. When multiple
        -- patterns match a link the one with the longer pattern is used.
        -- The key is for healthcheck and to allow users to change its values, value type below.
        -- | pattern   | matched against the destination text, @see :h lua-pattern       |
        -- | icon      | gets inlined before the link text                               |
        -- | highlight | optional highlight for 'icon', uses fallback highlight if empty |
        custom = {
          web = { pattern = '^http', icon = '󰖟 ' },
          discord = { pattern = 'discord%.com', icon = '󰙯 ' },
          github = { pattern = 'github%.com', icon = '󰊤 ' },
          gitlab = { pattern = 'gitlab%.com', icon = '󰮠 ' },
          google = { pattern = 'google%.com', icon = '󰊭 ' },
          neovim = { pattern = 'neovim%.io', icon = ' ' },
          reddit = { pattern = 'reddit%.com', icon = '󰑍 ' },
          stackoverflow = { pattern = 'stackoverflow%.com', icon = '󰓌 ' },
          wikipedia = { pattern = 'wikipedia%.org', icon = '󰖬 ' },
          youtube = { pattern = 'youtube%.com', icon = '󰗃 ' },
        },
      },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = {},
      },
      checkbox = {
        enabled = true,
      },
    },
    ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      Snacks.toggle({
        name = "Render Markdown",
        get = function()
          return require("render-markdown.state").enabled
        end,
        set = function(enabled)
          local m = require("render-markdown")
          if enabled then
            m.enable()
          else
            m.disable()
          end
        end,
      }):map("<leader>um")
    end,
  }
}
