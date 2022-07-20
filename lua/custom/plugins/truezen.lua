local present, plug = pcall(require, "true-zen")

if not present then
  return
end

plug.setup({
  ui = {
    top = {
      showtabline = 0,
    },
    left = {
      number = false,
    },
  },
  modes = {
    ataraxis = {
      left_padding = 3,
      right_padding = 3,
      top_padding = 1,
      bottom_padding = 0,
      auto_padding = false,
    },
  },
})
