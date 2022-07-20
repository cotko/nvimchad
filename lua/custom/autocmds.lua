local autocmd = vim.api.nvim_create_autocmd
print('awer')
print('awer')

vim.cmd "autocmd! BufRead,BufNewFile *.json setlocal! syntax=jsonc"

autocmd(
  { "BufNewFile", "BufRead" },
  {
    pattern = "*.json",
    callback = function() 
      print("KVAAAA")
      vim.cmd "sleep 3000ms | set ft=jsonc syntax=jsonc"
      print("KVAAAA22")
      print("KVAAAA22")
    end
  }
)
print('awer')
print('awer')
