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
}
