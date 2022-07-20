return function()
  vim.opt.relativenumber = true
  vim.opt.number = true
  vim.opt.list = true
  vim.opt.listchars = "tab:▸ ,eol:¬,trail:~"

  vim.g.sts = 2
  vim.g.sw = 2
  vim.g.ts = 2
  vim.g.expandtab = true


  vim.g.mapleader = ','
end
