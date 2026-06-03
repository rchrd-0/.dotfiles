return {
  {
    "stevearc/oil.nvim",
    enabled = true,
    lazy = false,
    cmd = "Oil",
    keys = {
      {
        "\\",
        function()
          require("oil").toggle_float()
        end,
        { desc = "Toggle Oil float" },
      },
      {
        "<leader>\\",
        function()
          require("oil").open()
        end,
        { desc = "Open parent directory in Oil" },
      },
    },
    opts = {
      win_options = {
        signcolumn = "yes:1",
      },
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
      columns = {
        "icon",
      },
      keymaps = {
        ["<C-s>"] = false,
        ["<C-h>"] = false,
        ["<C-t>"] = false,
        ["<C-l>"] = false,
        ["<C-p>"] = false,
        ["<M-p>"] = "actions.preview",
        ["<C-o>v"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
        ["<C-o>s"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
        ["<C-o>r"] = { "actions.refresh", desc = "[R]efresh" },
      },
      float = {
        border = "single",
        max_width = 0.5,
        max_height = 0.6,
        win_options = {
          winblend = 0,
        },
      },
      confirmation = {
        border = "single",
      },
      keymaps_help = {
        border = "single",
      },
    },
  },
  {
    "refractalize/oil-git-status.nvim",
    dependencies = {
      "stevearc/oil.nvim",
    },
    config = true,
  },
}
