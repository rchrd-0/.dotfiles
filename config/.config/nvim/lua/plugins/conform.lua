return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "biome-check", "prettierd", stop_after_first = true },
        typescript = { "biome-check", "prettierd", stop_after_first = true },
        javascriptreact = { "biome-check", "prettierd", stop_after_first = true },
        typescriptreact = { "biome-check", "prettierd", stop_after_first = true },
        vue = {
          "biome",
          "prettierd",
          stop_after_first = true,
        },
        svelte = {
          "biome",
          "prettierd",
          stop_after_first = true,
        },
        json = { "biome-check", "jsonls", stop_after_first = true },
        lua = { "stylua" },
      },
      formatters = {
        prettierd = {
          require_cwd = true,
        },
        ["biome-check"] = {
          require_cwd = false,
        },
      },
    },
  },
}
