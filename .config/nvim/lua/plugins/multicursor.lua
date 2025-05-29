return {
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
    set({ "n", "v" }, "<A-x>", mc.deleteCursor)       -- Delete cursor
    set({ "n", "v" }, "<A-c>", mc.toggleCursor)       -- Toggle cursor
    set({ "n", "v" }, "<A-d>", mc.duplicateCursors)   -- Duplicate cursors

    -- Mouse support
    set("n", "<C-LeftMouse>", mc.handleMouse)

    -- Restore cursors with Alt+r
    set("n", "<A-r>", mc.restoreCursors)

    -->Column operations with Alt+=
    set("n", "<A-=>", mc.alignCursors)

    -- Visual mode operations
    set("v", "<A-s>", mc.splitCursors)   -- Split selections
    set("v", "<A-m>", mc.matchCursors)   -- Match within selection

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
  end
}
