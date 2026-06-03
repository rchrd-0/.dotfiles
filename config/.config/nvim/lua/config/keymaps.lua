-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local del = vim.keymap.del

del({ "n", "x" }, "k")
del({ "n", "x" }, "<Down>")
del({ "n", "x" }, "j")
del({ "n", "x" }, "<Up>")
del("n", "<A-j>")
del("n", "<A-k>")
del("i", "<A-j>")
del("i", "<A-k>")
del("v", "<A-j>")
del("v", "<A-k>")

-- map("n", "<C-O>", "<C-i>")

map("n", "<M-w>", "<C-w>w", { desc = "Switch windows" })

map("n", '<C-w>"', "<C-w>s", { desc = "Split window" })
map("n", "<C-w>%", "<C-w>v", { desc = "Split window vertically" })

local signature_help = require("rchrd.signature_help")

-- Dismiss signature help from anywhere when the popup is open.
map({ "n", "i" }, "<M-g>", function()
  if signature_help.dismiss() then
    return
  end
  return "<M-g>"
end, { expr = true, silent = true, desc = "Dismiss signature help" })

-- LSP signature maps live on source buffers; after focus the popup is filetype=noice.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("rchrd_noice_signature", { clear = true }),
  pattern = "noice",
  callback = function(event)
    map({ "n", "i" }, "<C-g>", signature_help.close, {
      buffer = event.buf,
      desc = "Close signature help",
    })
    map({ "n", "i" }, "<M-g>", function()
      if signature_help.dismiss() then
        return
      end
      return "<M-g>"
    end, { buffer = event.buf, expr = true, silent = true, desc = "Dismiss signature help" })
  end,
})

map("n", "<M-[>", "<cmd>e#<cr>", { desc = "Switch to Other Buffer", remap = true })
map("n", "<M-]>", "<cmd>e#<cr>", { desc = "Switch to Other Buffer", remap = true })

map("n", "<leader><Tab>n", "<cmd>:tabnext<cr>", { desc = "Next Tab", remap = true, silent = true })
map("n", "<leader><Tab>p", "<cmd>:tabprev<cr>", { desc = "Previous Tab", remap = true, silent = true })

map({ "n", "v" }, "<leader>y", '"+y', { noremap = true, desc = "Yank to system clipboard" })
map({ "n", "v" }, "<leader>Y", '"+Y', { noremap = true, desc = "Yank line to system clipboard" })
map({ "n", "v" }, "<leader>d", '"_d', { noremap = true, desc = "Delete to black hole register" })

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "G", "Gzz")

map("n", "ZA", "<cmd>qa<cr>", { silent = true })

map("n", "<M-h>", ":TmuxNavigateLeft<CR>", { noremap = true, silent = true })
map("n", "<M-j>", ":TmuxNavigateDown<CR>", { noremap = true, silent = true })
map("n", "<M-k>", ":TmuxNavigateUp<CR>", { noremap = true, silent = true })
map("n", "<M-l>", ":TmuxNavigateRight<CR>", { noremap = true, silent = true })
map("n", "<M-\\>", ":TmuxNavigatePrevious<CR>", { noremap = true, silent = true })
