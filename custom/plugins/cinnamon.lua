local fn = require"custom.functions.shared"

local function setup()
  local present, plug = pcall(require, "cinnamon")
  if not present then
    return
  end

  plug.setup {}
end

if not fn.isNeovide() then
  setup()
end
