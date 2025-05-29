return
{
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
