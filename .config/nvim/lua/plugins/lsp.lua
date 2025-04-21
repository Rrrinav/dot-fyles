return {
  {
    "williamboman/mason.nvim",
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
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",        -- Lua
        "rust_analyzer", -- Rust
        "clangd",        -- C/C++
        -- Add more LSPs as needed
      },
      automatic_installation = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      inlay_hints = { enabled = false },
    },
    dependencies = {
      "mason.nvim",
      "mason-lspconfig.nvim",
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
      -- on_attach function for LSP key mappings
      local on_attach = function(client, bufnr)
        -- if client.server_capabilities.inlayHintProvider then
        --     vim.lsp.inlay_hint.enable()
        -- end
        vim.keymap.set(
          "n",
          "gD",
          "<cmd>lua vim.lsp.buf.declaration()<CR>",
          with_desc("Go to declaration", bufnr)
        ) -- Go to declaration
        vim.keymap.set("n", "gd", function()
          vim.lsp.buf.definition()
          if #vim.fn.getqflist() == 1 then vim.cmd('cc 1') end
        end, with_desc("Go to definition", bufnr))                                              -- Go to definition

        vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", with_desc("Hover", bufnr)) -- Hover
        -- Diagnostics
        vim.keymap.set(
          "n",
          "[d",
          "<cmd>lua vim.diagnostic.goto_prev()<CR>",
          with_desc("Go to previous diagnostic", bufnr)
        ) -- Go to previous diagnostic
        vim.keymap.set(
          "n",
          "]d",
          "<cmd>lua vim.diagnostic.goto_next()<CR>",
          with_desc("Go to next diagnostic", bufnr)
        ) -- Go to next diagnostic
        vim.keymap.set(
          "n",
          "<leader>e",
          "<cmd>lua vim.diagnostic.open_float()<CR>",
          with_desc("Show line diagnostics", bufnr)
        ) -- Show line diagnostics
      end
      -- LSP keymaps with vertical splits
      vim.keymap.set("n", "gbD", function()
        vim.cmd('vsplit')
        vim.lsp.buf.declaration()
      end, with_desc("Go to declaration in vsplit", bufnr))

      vim.keymap.set("n", "gbd", function()
        vim.cmd('vsplit')
        vim.lsp.buf.definition()
        if #vim.fn.getqflist() == 1 then
          vim.cmd('cc 1')
        end
      end, with_desc("Go to definition in vsplit", bufnr))

      vim.keymap.set("n", "gbr", function()
        vim.cmd('vsplit')
        vim.lsp.buf.references()
      end, with_desc("Go to references in vsplit", bufnr))

      vim.keymap.set("n", "gbI", function()
        vim.cmd('vsplit')
        vim.lsp.buf.implementation()
      end, with_desc("Go to implementation in vsplit", bufnr))
      -- Default LSP configuration to apply to all servers
      local default_config = {
        on_attach = on_attach,
      }
      -- Automatically setup servers installed via Mason
      require("mason-lspconfig").setup_handlers({
        -- Default handler
        function(server_name)
          lspconfig[server_name].setup(default_config)
        end,
        ["pylsp"] = function()
          lspconfig.pyright.setup(vim.tbl_extend("force", default_config, {
            settings = {
              pylsp = {
                plugins = {
                  jedi_completion = {
                    include_params = true,
                  },
                  pycodestyle = { enabled = false },
                },
              },
            },
          }))
        end,
      })
    end,
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
