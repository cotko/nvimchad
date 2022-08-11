local override = require "custom.overrides"

return {

  ui = {
    -- theme = "monekai",
    theme = "onedark",
  },

  plugins = {
    user = require "custom.plugins",
    override = override,
    remove = {
      -- "kyazdani42/nvim-tree.lua",
    },
  },

  mappings = require "custom.mappings",
}
