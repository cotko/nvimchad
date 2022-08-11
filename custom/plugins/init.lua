
return {
  ["rcarriga/nvim-notify"] = {},
  ['rgarver/Kwbd.vim'] = {},
  -- ["nvim-neorg/neorg"] = {
  --   ft = "norg",
  --   after = "nvim-treesitter",
  --   config = function()
  --     require "custom.plugins.neorg"
  --   end,
  -- },

  ["declancm/cinnamon.nvim"] = {
    config = function()
       require "custom.plugins.cinnamon"
    end,
  },
}
