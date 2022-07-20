local present = pcall(require, "chadtree")

if not present then
  return
end

vim.api.nvim_set_var("chadtree_settings", {
  keymap = {
    refresh = {"r"},

    -- file managing
    rename = {"mr"},
  }
})
