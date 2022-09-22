local fn = require "custom.functions.util"
if fn.isNeovide() then return end

local present, plug = pcall(require, "cinnamon")
if not present then
  return
end

plug.setup {}
