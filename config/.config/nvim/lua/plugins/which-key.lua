return {
  "folke/which-key.nvim",
  ---@module 'which-key'
  ---@class wk.Opts
  opts = {
    preset = "helix",
    win = {
      border = "single",
    },
    ---@type wk.Spec
    spec = {
      {
        "<leader>o",
        group = "Obsidian",
        mode = { "n", "v" },
      },
    },
  },
}
