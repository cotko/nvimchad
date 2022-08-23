
vim.filetype.add({
  extension = {
    json = "jsonc",
    ejs = "html",
    mts = "typescript",
    mjs = "javascript"
  },
  filename = {
    [".eslintrc"] = "json"
  }

})
