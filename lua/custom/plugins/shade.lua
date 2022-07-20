local present, plug = pcall(require, "shade")

if not present then
  return
end

plug.setup {
  overlay_opacity = 75,
  opacity_step = 1,
  exclude_filetypes = { "NvimTree" },
}
