local present, sm = pcall(require, "session_manager")

if not present then
  return
end

sm.setup({
  autoload_mode = "Disabled"
})

local config_group = vim.api.nvim_create_augroup('MyConfigGroup', {})

vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = 'SessionLoadPost',
  group  = config_group,
  callback = function()
    require('nvim-tree').toggle(false, true)
  end
})
