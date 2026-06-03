vim.g.suggestion_provider = "copilot"

local disabled_paths = {
  "$HOME/Library/CloudStorage/OneDrive-Personal/05_Obsidian",
}
-- local ignore_filetypes = {
--   "bigfile",
--   "snacks_input",
--   "snacks_notif",
--   "snacks_picker_input",
--   "trouble",
-- }

local is_disabled = function(this_buffer)
  for _, path in ipairs(disabled_paths) do
    -- print(path)
    if string.find(this_buffer, vim.fn.expand(path), 1, true) ~= nil then
      -- print("Disabling for buffer: " .. this_buffer)
      return true
    end
  end
  return false
end

return {
  {
    "zbirenbaum/copilot.lua",
    opts = function(_, opts)
      -- local filetypes = {}
      -- for _, ft in ipairs(ignore_filetypes) do
      --   filetypes[ft] = false
      -- end
      --

      opts.filetypes = {
        bigfile = false,
        snacks_input = false,
        snacks_notif = false,
        snacks_picker_input = false,
        trouble = false,
      }
      vim.list_extend(opts.suggestion, {
        enabled = vim.g.suggestion_provider == "copilot",
      })

      opts.should_attach = function(_, bufname)
        return not is_disabled(bufname)
      end
    end,
  },
  {
    "folke/sidekick.nvim",
    -- keys = {
    --   {
    --     "<leader>ao",
    --     function()
    --       require("sidekick.cli").toggle({ name = "opencode", focus = true })
    --     end,
    --     desc = "Sidekick Opencode Toggle",
    --   },
    -- },
  },
  -- {
  --   "milanglacier/minuet-ai.nvim",
  --   enabled = false,
  --   opts = {
  --     virtualtext = {
  --       -- Specify the filetypes to enable automatic virtual text completion,
  --       -- e.g., { 'python', 'lua' }. Note that you can still invoke manual
  --       -- completion even if the filetype is not on your auto_trigger_ft list.
  --       auto_trigger_ft = { "*" },
  --       -- specify file types where automatic virtual text completion should be
  --       -- disabled. This option is useful when auto-completion is enabled for
  --       -- all file types i.e., when auto_trigger_ft = { '*' }
  --       auto_trigger_ignore_ft = {
  --         "bigfile",
  --         "snacks_input",
  --         "snacks_notif",
  --         "snacks_picker_input",
  --         "trouble",
  --       },
  --       keymap = {
  --         accept = "<M-l>",
  --         accept_line = "<M-.>",
  --         accept_n_lines = nil,
  --         -- Cycle to next completion item, or manually invoke completion
  --         next = "<M-]>",
  --         -- Cycle to prev completion item, or manually invoke completion
  --         prev = "<M-[>",
  --         dismiss = "<C-]>",
  --       },
  --       -- Whether show virtual text suggestion when the completion menu
  --       -- (nvim-cmp or blink-cmp) is visible.
  --       show_on_completion_menu = false,
  --     },
  --     provider = "openai_compatible",
  --     request_timeout = 2.5,
  --     throttle = 1500, -- Increase to reduce costs and avoid rate limits
  --     debounce = 600, -- Increase to reduce costs and avoid rate limits
  --     provider_options = {
  --       openai_compatible = {
  --         api_key = "OPENROUTER_API_KEY",
  --         end_point = "https://openrouter.ai/api/v1/chat/completions",
  --         model = "deepseek/deepseek-v4-flash",
  --         name = "Openrouter",
  --         optional = {
  --           max_tokens = 56,
  --           top_p = 0.9,
  --           provider = {
  --             -- Prioritize throughput for faster completion
  --             sort = "throughput",
  --           },
  --           -- disable thinking to avoid first token latency
  --           reasoning_effort = "none",
  --         },
  --       },
  --     },
  --   },
  -- },
}
