return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      inlay_hints = {
        enabled = false,
        exclude = { "vue" },
      },
      diagnostics = {
        virtual_text = {
          severity = { min = vim.diagnostic.severity.ERROR },
        },
        underline = true,
      },
      servers = {
        ["*"] = {
          keys = {
            {
              "<C-g>",
              require("rchrd.signature_help").toggle,
              mode = { "i", "n" },
              desc = "Signature Help (toggle)",
              has = "signatureHelp",
            },
            -- { "<C-k>", false, mode = "i" },
            --     { "<leader>e", vim.diagnostic.open_float, desc = "Line Diagnostics" },
            --     {
            --       "<leader>rn",
            --       function()
            --         local inc_rename = require("inc_rename")
            --         return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
            --       end,
            --       expr = true,
            --       desc = "Rename (inc-rename.nvim)",
            --       has = "rename",
            --     },
          },
        },
        vtsls = {
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "tsx",
            "vue",
            -- "svelte",
          },
          enableMoveToFileCodeAction = true,
          autoUseWorkspaceTsdk = true,
          experimental = {
            maxInlayHintLength = 30,
            completion = {
              enableServerSideFuzzyMatch = true,
            },
          },
          settings = {
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "all" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
              preferences = {
                useAliasesForRenames = false,
                importModuleSpecifier = "non-relative",
              },
            },
            vtsls = {
              tsserver = {
                globalPlugins = {
                  {
                    name = "@vue/typescript-plugin",
                    location = LazyVim.get_pkg_path("vue-language-server", "/node_modules/@vue/language-server"),
                    languages = { "vue" },
                    configNamespace = "typescript",
                    enableForWorkspaceTypeScriptVersions = true,
                  },
                },
              },
            },
          },
        },
        oxlint = {
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "vue",
          },
        },
        cssls = {
          settings = {
            css = { validate = true, lint = { unknownAtRules = "ignore" } },
            scss = { validate = true, lint = { unknownAtRules = "ignore" } },
          },
        },
        tailwindcss = {
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "vue",
            "html",
            "svelte",
          },
          settings = {
            tailwindCSS = {
              includeLanguages = {
                elixir = "html-eex",
                eelixir = "html-eex",
                heex = "html-eex",
              },
              classAttributes = {
                "class",
                "className",
                "class:list",
                "classList",
                "ngClass",
                ".*ClassName",
                "tw.*",
                "ping",
              },
              classFunctions = { "cn", "clsx", "cva" },
            },
          },
        },
        solidity_ls_nomicfoundation = {},
      },
    },
  },
}
