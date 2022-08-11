local autocmd = vim.api.nvim_create_autocmd

autocmd(
  { "FileType" },
  {
    pattern = "json",
    callback = function() 
      vim.cmd "set ft=jsonc syntax=jsonc"
    end
  }
)
