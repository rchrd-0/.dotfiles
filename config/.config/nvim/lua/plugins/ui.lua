return {
  {
    "folke/noice.nvim",
    enabled = true,
    opts = {
      lsp = {
        signature = {
          enabled = true,
          auto_open = {
            enabled = true,
          },
        },
      },
      views = {
        cmdline_popup = {
          position = {
            row = 15,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
          border = {
            style = "single",
          },
        },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        style_preset = {
          require("bufferline").style_preset.no_italic,
        },
        always_show_bufferline = true,
        show_buffer_close_icons = false,
        indicator = {
          icon = "",
          style = "icon",
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      local icons = LazyVim.config.icons
      local copilot_icons = {
        Error = { " ", "DiagnosticError" },
        Inactive = { " ", "MsgArea" },
        Warning = { " ", "DiagnosticWarn" },
        Normal = { LazyVim.config.icons.kinds.Copilot, "Special" },
      }

      opts.options = {
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      }
      opts.sections.lualine_c = {
        LazyVim.lualine.root_dir(),
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
        { LazyVim.lualine.pretty_path() },
      }

      opts.sections.lualine_x = {
        {
          function()
            local status = require("sidekick.status").get()
            return status and vim.tbl_get(copilot_icons, status.kind, 1)
          end,
          cond = function()
            return require("sidekick.status").get() ~= nil
          end,
          color = function()
            local status = require("sidekick.status").get()
            local hl = status and (status.busy and "DiagnosticWarn" or vim.tbl_get(copilot_icons, status.kind, 2))
            return { fg = Snacks.util.color(hl) }
          end,
        },
        {
          function()
            return require("noice").api.status.command.get()
          end,
          cond = function()
            return package.loaded["noice"] and require("noice").api.status.command.has()
          end,
          color = function()
            return { fg = Snacks.util.color("Statement") }
          end,
        },
        {
          function()
            return require("noice").api.status.mode.get()
          end,
          cond = function()
            return package.loaded["noice"] and require("noice").api.status.mode.has()
          end,
          color = function()
            return { fg = Snacks.util.color("Constant") }
          end,
        },
        {
          "diff",
          symbols = {
            added = icons.git.added,
            modified = icons.git.modified,
            removed = icons.git.removed,
          },
          source = function()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
              }
            end
          end,
        },
      }
      --
      opts.sections.lualine_y = {
        { "filetype", icon_only = false, separator = "", padding = { left = 1, right = 1 } },
      }
      opts.sections.lualine_z = { { "location" } }

      if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
        local trouble = require("trouble")
        local symbols = trouble.statusline({
          mode = "symbols",
          groups = {},
          title = false,
          filter = { range = true },
          format = "{kind_icon}{symbol.name:Normal}",
          hl_group = "lualine_c_normal",
        })
        table.insert(opts.sections.lualine_c, {
          symbols and symbols.get,
          cond = function()
            return vim.b.trouble_lualine ~= false and symbols.has()
          end,
        })
      end
      return opts
    end,
  },
}
