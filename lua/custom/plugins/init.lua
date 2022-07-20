
return {
  ["rcarriga/nvim-notify"] = {},
  ['rgarver/Kwbd.vim'] = {},
  ["Pocco81/TrueZen.nvim"] = {
    cmd = {
      "TZAtaraxis",
      "TZMinimalist",
      "TZFocus",
    },
    config = function()
      require "custom.plugins.truezen"
    end,
  },

  -- ["nvim-neorg/neorg"] = {
  --   ft = "norg",
  --   after = "nvim-treesitter",
  --   config = function()
  --     require "custom.plugins.neorg"
  --   end,
  -- },

  -- ["andreadev-it/shade.nvim"] = {
  --   module = 'shade',
  --   config = function()
  --     require "custom.plugins.shade"
  --   end,
  -- },

  ["declancm/cinnamon.nvim"] = {
    config = function()
       require "custom.plugins.cinnamon"
    end,
  },

  -- ["ms-jpq/chadtree"] = {
  --   config = function()
  --     require "custom.plugins.chadtree"
  --   end,
  -- },

}
