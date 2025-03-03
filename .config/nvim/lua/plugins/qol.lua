return {
    { 'echasnovski/mini.cursorword', version = '*' },
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
    { "nvzone/volt",                 { "nvzone/timerly", cmd = "TimerlyToggle" } },
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
        "nvzone/minty",
        cmd = { "Shades", "Huefy" },
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup {}
        end
    },
    {
        "windwp/nvim-ts-autotag",
        opts = {},
    },
    {
        "jake-stewart/multicursor.nvim",
        branch = "1.0",
        config = function()
            local mc = require("multicursor-nvim")
            mc.setup()
            local set = vim.keymap.set

            -- Main cursor management - Alt+Up/Down for vertical cursors
            set({ "n", "v" }, "<A-Up>",
                function() mc.lineAddCursor(-1) end)
            set({ "n", "v" }, "<A-Down>",
                function() mc.lineAddCursor(1) end)

            set("n", "<A-right>", function()
                mc.addCursor("w")
            end)
            set("n", "<A-S-right>", function()
                mc.skipCursor("w")
            end)

            set("n", "<A-left>", function()
                mc.addCursor("b")
            end)
            set("n", "<A-S-left>", function()
                mc.skipCursor("b")
            end)
            -- Skip lines with Alt+Shift+Up/Down
            set({ "n", "v" }, "<A-S-u>",
                function() mc.lineSkipCursor(-1) end)
            set({ "n", "v" }, "<A-S-d>",
                function() mc.lineSkipCursor(1) end)

            -- Word matching with Alt+/ and Alt+?
            set({ "n", "v" }, "<A-/>",
                function() mc.matchAddCursor(1) end)
            set({ "n", "v" }, "<A-?>",
                function() mc.matchAddCursor(-1) end)

            -- Skip matches with Alt+Shift+/ and Alt+Shift+?
            set({ "n", "v" }, "<A-S-/>",
                function() mc.matchSkipCursor(1) end)
            set({ "n", "v" }, "<A-S-?>",
                function() mc.matchSkipCursor(-1) end)

            -- Add all matches with Alt+a
            set({ "n", "v" }, "<A-a>", mc.matchAllAddCursors)

            -- Navigate between cursors with Alt+[ and Alt+]
            set({ "n", "v" }, "<A-[>", mc.prevCursor)
            set({ "n", "v" }, "<A-]>", mc.nextCursor)

            -- Quick cursor management
            set({ "n", "v" }, "<A-x>", mc.deleteCursor)     -- Delete cursor
            set({ "n", "v" }, "<A-c>", mc.toggleCursor)     -- Toggle cursor
            set({ "n", "v" }, "<A-d>", mc.duplicateCursors) -- Duplicate cursors

            -- Mouse support
            set("n", "<C-LeftMouse>", mc.handleMouse)

            -- Restore cursors with Alt+r
            set("n", "<A-r>", mc.restoreCursors)

            -->Column operations with Alt+=
            set("n", "<A-=>", mc.alignCursors)

            -- Visual mode operations
            set("v", "<A-s>", mc.splitCursors) -- Split selections
            set("v", "<A-m>", mc.matchCursors) -- Match within selection

            -- Visual mode insert/append
            set("v", "<A-i>", mc.insertVisual)
            set("v", "<A-a>", mc.appendVisual)

            -- Transpose operations
            set("v", "<A-t>",
                function() mc.transposeCursors(1) end)
            set("v", "<A-T>",
                function() mc.transposeCursors(-1) end)

            -- Jumplist (using default keys since they're standard)
            set({ "v", "n" }, "<C-i>", mc.jumpForward)
            set({ "v", "n" }, "<C-o>", mc.jumpBackward)

            -- ESC behavior
            set("n", "Q", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                elseif mc.hasCursors() then
                    mc.clearCursors()
                else
                    -- Default <Esc> handler
                    vim.cmd("norm! <Esc>")
                end
            end)

            -- Customize cursor appearances
            local hl = vim.api.nvim_set_hl
            hl(0, "MultiCursorCursor", {
                bg = "#666666",
                fg = "#ffffff",
                bold = true,
                nocombine = true
            })
            -- Visual selections: semi-transparent blue
            hl(0, "MultiCursorVisual", {
                bg = "#264f78",
                blend = 50
            })
            -- Sign column indicators
            hl(0, "MultiCursorSign", {
                fg = "#666666",
                bold = true
            })
            -- Disabled cursor state: dimmed purple
            hl(0, "MultiCursorDisabledCursor", {
                bg = "#663399",
                fg = "#cccccc"
            })
            -- Disabled visual state: very dim blue
            hl(0, "MultiCursorDisabledVisual", {
                bg = "#1a3352",
                blend = 70
            })
            -- Disabled sign state
            hl(0, "MultiCursorDisabledSign", {
                fg = "#663399",
                blend = 50
            })
        end
    },
    {
        'lewis6991/impatient.nvim'
    },
}
