return {
  {
    "lewis6991/gitsigns.nvim",
    enabled = true,
    opts = {
      current_line_blame = true,
    },
    keys = {
      {
        "<leader>uB",
        function()
          local gitsigns = require("gitsigns")
          gitsigns.toggle_current_line_blame()
        end,
        mode = { "n" },
        desc = "Toggle current line blame",
      },
    },
  },
}
