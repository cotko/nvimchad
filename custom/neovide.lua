local fn = require"custom.functions.shared"
if not fn.isNeovide() then return end

vim.g.neovide_scroll_animation_length=0.5
vim.g.neovide_cursor_antialiasing=true
-- vim.g.neovide_cursor_animation_length=0.1
-- vim.g.neovide_cursor_trail_length=0.1

