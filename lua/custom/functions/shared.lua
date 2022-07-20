local has_notify, notify = pcall(require, "notify")

return {
  warn = function (msg)
    vim.schedule(function()
      if has_notify then
        notify(msg, vim.log.levels.WARN, { title = "NvimTree" })
      else
        vim.notify("[NvimTree] " .. msg, vim.log.levels.WARN)
      end
    end)
  end


}
