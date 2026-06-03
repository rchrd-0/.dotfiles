local M = {}

---@return NoiceMessage?
local function message()
  return require("noice.lsp.docs")._messages.signature
end

--- Close signature help whenever the popup is open (any window focused).
function M.dismiss()
  local msg = message()
  local win = msg and msg:win()
  if win then
    require("noice.lsp.docs").hide(msg)
    return true
  end
end

--- Close signature help when the popup window is focused (<C-g> in the noice buffer).
function M.close()
  local msg = message()
  local win = msg and msg:win()
  if win and vim.api.nvim_get_current_win() == win then
    require("noice.lsp.docs").hide(msg)
    return true
  end
end

--- Open → focus popup → close (close works from the noice popup via FileType autocmd).
function M.toggle()
  local msg = message()
  local win = msg and msg:win()

  if M.close() then
    return
  end
  if win then
    msg:focus()
    return
  end
  vim.lsp.buf.signature_help()
end

return M
