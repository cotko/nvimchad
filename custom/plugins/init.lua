return {
  ["rcarriga/nvim-notify"] = {},
  ['rgarver/Kwbd.vim'] = {},
  ["declancm/cinnamon.nvim"] = {
    config = function()
      require "custom.plugins.cinnamon"
    end,
  },
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
  ['folke/trouble.nvim'] = {
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require "custom.plugins.trouble"
    end
  },
  ["folke/which-key.nvim"] = {
    disable = false
  },
  ['jose-elias-alvarez/typescript.nvim'] = {
    requires = "neovim/nvim-lspconfig"
  },
  ["Shatur/neovim-session-manager"] = {
    config = function()
      require"custom.plugins.session_manager"
    end,
  },
  ["goolord/alpha-nvim"] = {
    after = {"neovim-session-manager", "base46"},
    disable = true,
    config = function()
      require "custom.plugins.alpha"
    end,
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null_ls"
    end,
  },
  ["nvim-telescope/telescope-ui-select.nvim"] = {},
  ["nvim-treesitter/playground"] = {},
  ["nvim-treesitter/nvim-treesitter-textobjects"] = {},
}
