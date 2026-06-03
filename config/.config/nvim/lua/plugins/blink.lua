return {
  {
    "saghen/blink.cmp",
    enabled = true,
    opts = {
      signature = { enabled = false, window = {
        show_documentation = true,
      } },
      keymap = {
        ["<C-g>"] = { "show_signature", "hide_signature", "fallback" },
      },
    },
  },
}
