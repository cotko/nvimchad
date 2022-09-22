return {
  ["rcarriga/nvim-notify"] = {},
  ['rgarver/Kwbd.vim'] = {},
  ["nvim-telescope/telescope-ui-select.nvim"] = {},
  ["nvim-treesitter/playground"] = {},
  ["nvim-treesitter/nvim-treesitter-textobjects"] = {},
  ["folke/which-key.nvim"] = {
    disable = false,
  },

  ["kyazdani42/nvim-tree.lua"] = require 'custom.plugins.nvimtree',
  ["lewis6991/gitsigns.nvim"] = require "custom.plugins.gitsigns",

  ["nvim-treesitter/nvim-treesitter"] = require "custom.plugins.treesitter",
  ["williamboman/mason.nvim"] = require "custom.plugins.mason",
  ["nvim-telescope/telescope.nvim"] = require "custom.plugins.telescope",

  ["declancm/cinnamon.nvim"] = {
    config = function()
      require "custom.plugins.cinnamon"
    end,
  },
  ["neovim/nvim-lspconfig"] = {
    requires = "williamboman/mason-lspconfig.nvim",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
  ["williamboman/mason-lspconfig.nvim"] = {
    requires = "williamboman/mason.nvim",
    config = function()
      require('mason-lspconfig').setup()
    end
  },
  -- ['folke/trouble.nvim'] = {
  --   requires = "kyazdani42/nvim-web-devicons",
  --   config = function()
  --     require "custom.plugins.trouble"
  --   end
  -- },
  -- ['jose-elias-alvarez/typescript.nvim'] = {
  --   requires = "neovim/nvim-lspconfig"
  -- },
  -- ["Shatur/neovim-session-manager"] = {
  --   config = function()
  --     require"custom.plugins.session_manager"
  --   end,
  -- },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null_ls"
    end,
  },
}
