return {
  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      keywords = {
        DOUBT = { icon = " ", color = "#ff9911" },
      },
    },
  },
  -- Timerly
  {
    "nvzone/volt",
    { "nvzone/timerly", cmd = "TimerlyToggle" }
  },
  -- Venn
  {
    "jbyuki/venn.nvim",
  },
  -- luarocks
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    config = true,
  },
  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },
  {
    'lewis6991/impatient.nvim'
  },
  {
    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-ui",
    "kristijanhusak/vim-dadbod-completion", -- Optional for SQL completion
    dependencies = { "tpope/vim-dadbod" }
  }
}
