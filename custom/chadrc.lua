local overrides = require "custom.overrides"

return {

  ui = {
    -- theme = "monekai",
    theme = "onedark",
  },

  plugins = {
    user = require "custom.plugins",
    options = {
      lspconfig = {
        setup_lspconf = "custom.plugins.lspconfig",
      }
    },
    override = {
     ["kyazdani42/nvim-tree.lua"] = overrides.nvimtree,
     ["nvim-treesitter/nvim-treesitter"] = overrides.treesitter,
     ["williamboman/mason"] = overrides.mason,
    },
    remove = {
      -- "kyazdani42/nvim-tree.lua",
    },
  },

  mappings = require "custom.mappings",
}
