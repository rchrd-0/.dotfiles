return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    -- ft = "markdown",
    -- event = {
    --   "BufReadPre " .. vim.fn.expand("~") .. "/Library/CloudStorage/OneDrive-Personal/05_Obsidian/*",
    --   "BufNewFile " .. vim.fn.expand("~") .. "/Library/CloudStorage/OneDrive-Personal/05_Obsidian/*",
    -- },
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      legacy_commands = false,
      frontmatter = {
        enabled = true,
      },
      ui = {
        enable = false,
      },
      picker = {
        name = "snacks.pick",
      },
      completion = {
        blink = true,
      },
      workspaces = {
        {
          name = "personal",
          path = "~/Documents/obsidian-vaults/base",
        },
      },
      templates = {
        folder = "_templates",
        customizations = {
          default = {
            notes_subdir = "00-inbox",
            note_id_func = function(title)
              if title == nil then
                return nil
              end

              local name = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
              return name -- "Hulk Hogan" → "hulk-hogan"
            end,
          },
        },
      },
      attachments = {
        folder = "_attachments",
      },
      note = {
        template = "default.md",
      },
      note_id_func = function(title)
        if title == nil then
          return nil
        end

        local name = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        return name -- "Hulk Hogan" → "hulk-hogan"
      end,
      callbacks = {
        enter_note = function(note)
          local map = vim.keymap.set
          map("n", "<leader>oo", "<cmd>Obsidian<cr>", {
            buffer = note.bufnr,
            desc = "Search commands",
          })
          map("n", "<leader>on", "<cmd>Obsidian new<cr>", {
            buffer = note.bufnr,
            desc = "New",
          })
          map("n", "<leader>oc", "<cmd>Obsidian toggle_checkbox<cr>", {
            buffer = note.bufnr,
            desc = "Toggle checkbox",
          })
          map("n", "<leader>oc", "<cmd>Obsidian toggle_checkbox<cr>", {
            buffer = note.bufnr,
            desc = "Toggle checkbox",
          })
          map("n", "<leader>of", "<cmd>Obsidian quick_switch<cr>", {
            buffer = note.bufnr,
            desc = "Quick switch",
          })
          map("n", "<leader>og", "<cmd>Obsidian search<cr>", {
            buffer = note.bufnr,
            desc = "Search",
          })
          map("n", "<leader>ot", "<cmd>Obsidian tags<cr>", {
            buffer = note.bufnr,
            desc = "Tags",
          })
          map("v", "<leader>ol", "<cmd>Obsidian link<cr>", {
            buffer = note.bufnr,
            desc = "Link new",
          })
          map("n", "<leader>ob", "<cmd>Obsidian backlinks<cr>", {
            buffer = note.bufnr,
            desc = "Backlinks",
          })
          map("n", "<leader>ou", "<cmd>Obsidian links<cr>", {
            buffer = note.bufnr,
            desc = "View links",
          })
        end,
      },
    },
  },
}
