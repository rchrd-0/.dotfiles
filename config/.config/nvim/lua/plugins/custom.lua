local wiki_link_path_only = function(opts)
  ---@type string
  local header_or_block = ""
  if opts.anchor then
    header_or_block = opts.anchor.anchor
  elseif opts.block then
    header_or_block = string.format("#%s", opts.block.id)
  end
  return string.format("[[%s%s]]", opts.path, header_or_block)
end

return {
  {
    "folke/todo-comments.nvim",
    enabled = true,
    optional = true,
    opts = {
      keywords = {
        --stylua: ignore
        NOTE = { icon = " ", color = "hint", alt = { "INFO", "DEV", "dev"} },
        TODO = { icon = " ", color = "info", alt = { "todo" } },
      },
    },
    keys = {
      {
        "<leader>st",
        function()
          Snacks.picker.todo_comments()
        end,
        desc = "Todo",
      },
      {
        "<leader>sT",
        function()
          Snacks.picker.todo_comments({
            keywords = { "TODO", "todo", "FIX", "FIXME", "NOTE", "INFO", "DEV" },
          })
        end,
        desc = "Todo/Fix/Fixme",
      },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    init = function()
      -- Disable default mappings
      vim.g.tmux_navigator_no_mappings = 1
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      code = {
        sign = false,
        width = "block",
        left_pad = 1,
        right_pad = 5,
      },
      heading = {
        sign = true,
        width = "block",
        right_pad = 1,
        icons = {},
      },
      checkbox = {
        enabled = false,
        -- right_pad = 1,
      },
    },
    ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      Snacks.toggle({
        name = "Render Markdown",
        get = function()
          return require("render-markdown.state").enabled
        end,
        set = function(enabled)
          local m = require("render-markdown")
          if enabled then
            m.enable()
          else
            m.disable()
          end
        end,
      }):map("<leader>um")
    end,
  },
  {
    "sindrets/diffview.nvim",
  },
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      {
        "<leader>fs",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },
  { "monaqa/dial.nvim", event = "VeryLazy" },
}
