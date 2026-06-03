return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    lazy = false,
    opts = {
      variant = "main",
      dim_inactive_windows = true,
      styles = {
        italic = false,
        transparency = true,
      },
      -- palette = {
      --   main = {
      --     base = "#13121c",
      --   },
      -- },
      highlight_groups = {
        ["@markup.italic"] = { italic = true },
        ["@markup.italic.markdown_inline"] = { italic = true },
      },
    },
  },
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    priority = 1000,
    lazy = false,
    opts = {
      dimInactive = true,
      terminalColors = true,
      transparent = false,
      overrides = function(colors)
        local theme = colors.theme
        return {
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
        }
      end,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
    },
  },
  { "EdenEast/nightfox.nvim", lazy = false, priority = 1000, opts = {} },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
