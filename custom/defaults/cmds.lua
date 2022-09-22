-- TODO: refactor this
local cmd = vim.api.nvim_create_user_command
local fn_fonts = require "custom.functions.fonts"

cmd(
  "SelectGuiFont",
  function ()
    vim.ui.select(
      fn_fonts.getFonts(),
      { prompt = 'select' },
      function (item) fn_fonts.setNewGuiFont(item) end
    )
  end,
  { nargs = "*", desc = "Select and set GUI Font from available font list" }
)
