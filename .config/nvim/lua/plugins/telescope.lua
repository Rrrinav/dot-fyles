return {
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
        builtin.find_files(require("telescope.themes").get_ivy({
          no_ignore = true
        }))
      end,
      desc = "Lists files in your current working directory, does not respect .gitignore",
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
}
