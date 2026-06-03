return {
  {
    "folke/snacks.nvim",
    opts = {
      -- explorer = { enabled = false },
      indent = { enabled = false },
      notifier = { enabled = false },
      terminal = { enabled = false },
      lazygit = { enabled = false },
      zen = {
        enabled = true,
        toggles = {
          dim = false,
        },
      },
      styles = {
        zen = {
          minimal = false,
        },
        input = {
          border = "single",
        },
      },
      ---@class snacks.dashboard.Config
      dashboard = {
        enabled = true,
        width = 18,
        row = nil,
        col = nil,
        pane_gap = 4,
        preset = {
          header = "",
          keys = {
            {
              -- icon = " ",
              key = "f",
              desc = "find",
              action = ":lua Snacks.dashboard.pick('files')",
            },
            -- {
            --   -- icon = " ",
            --   key = "n",
            --   desc = "new",
            --   action = ":ene | startinsert",
            -- },
            {
              -- icon = " ",
              key = "g",
              desc = "grep",
              action = ":lua Snacks.dashboard.pick('live_grep')",
            },
            -- {
            --   -- icon = " ",
            --   key = "r",
            --   desc = "recent",
            --   action = ":lua Snacks.dashboard.pick('oldfiles')",
            -- },
            {
              -- icon = " ",
              key = "\\",
              desc = "oil",
              action = ":Oil",
            },
            -- {
            --   -- icon = " ",
            --   key = "c",
            --   desc = "config",
            --   action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            -- },
            {
              -- icon = " ",
              key = "s",
              desc = "restore",
              section = "session",
            },
            -- {
            --   -- icon = " ",
            --   key = "x",
            --   desc = "extras",
            --   action = ":LazyExtras",
            -- },
            -- {
            --   -- icon = "󰒲 ",
            --   key = "l",
            --   desc = "lazy",
            --   action = ":Lazy",
            -- },
            {
              -- icon = " ",
              key = "q",
              desc = "quit",
              action = ":qa",
            },
          },
        },
        sections = {
          { section = "keys", gap = 0, padding = 1 },
        },
      },
      picker = {
        sources = {
          explorer = {
            ---@class snacks.picker.layout.Config
            layout = {
              -- auto_hide = { "input" },
              preset = "sidebar",
              layout = {
                backdrop = false,
                width = 40,
                min_width = 40,
                height = 0,
                position = "right",
                border = "top",
                box = "vertical",
                title = " {live} {flags}",
                title_pos = "left",
                {
                  win = "input",
                  height = 1,
                  border = "bottom",
                },
                { win = "list", border = "none" },
                { win = "preview", title = "{preview}", height = 0.4, border = "top" },
              },
            },
            -- win = {
            --   list = {
            --     wo = {
            --       relativenumber = true,
            --     },
            --   },
            -- },
          },
        },
        exclude = {
          ".git/",
          "node_modules/",
          "dist/",
        },
        layouts = {
          default = {
            preview = false,
            layout = {
              backdrop = false,
              box = "horizontal",
              width = 0.5,
              min_width = 120,
              -- max_width = 120,
              height = 0.6,
              border = false,
              {
                box = "vertical",
                border = "single",
                title = "{title} {live} {flags}",
                { win = "input", height = 1, border = "bottom" },
                { win = "list", border = "none" },
              },
              {
                win = "preview",
                title = "{preview}",
                border = "single",
                width = 0.5,
              },
            },
          },
        },
        layout = {
          preset = "ivy",
          -- preset = function()
          --   return vim.o.columns >= 120 and "default" or "vertical"
          -- end,
        },
      },
    },
    keys = {
      -- { "<leader>e", mode = { "n" }, false },
      -- { "<leader>E", mode = { "n" }, false },
      -- { "<leader>fe", mode = { "n" }, false },
      -- { "<leader>fE", mode = { "n" }, false },

      {
        "<leader>'",
        function()
          Snacks.scratch()
        end,
        desc = "Toggle Scratch Buffer",
      },

      { "<leader>sf", LazyVim.pick("files", {
        hidden = true,
      }), desc = "Find Files (Root Dir)" },
      {
        "<leader>sy",
        function()
          Snacks.picker.registers()
        end,
        desc = "Registers",
      },
      {
        "<leader>sr",
        function()
          Snacks.picker.resume()
        end,
        desc = "Resume",
      },
      {
        "<leader>sR",
        function()
          Snacks.picker.recent({ filter = { cwd = true } })
        end,
        desc = "Recent (cwd)",
      },
      {
        "<leader><leader>",
        function()
          Snacks.picker.smart()
        end,
        desc = "Smart find files",
      },
      {
        "<leader>,",
        function()
          Snacks.picker.buffers({ hidden = true, nofile = false })
        end,
        desc = "Buffers (all)",
      },
      {
        "<leader>.",
        function()
          Snacks.picker.recent({ filter = { cwd = true } })
        end,
        desc = "Recent (cwd)",
      },
    },
  },
}
