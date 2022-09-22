local util = {}
local has_notify, notify = pcall(require, "notify")

util.reverseTable = function(t)
  local reversedTable = {}
  for k, v in pairs(t) do
    reversedTable[v] = k
  end

  return reversedTable
end


util.warn = function (msg, tag)
  if tag == nil then
    tag = "[Custom]"
  end
  vim.schedule(function()
    if has_notify then
      notify(
        msg,
        vim.log.levels.WARN,
        { title = tag }
      )
    else
      vim.notify(
        tag .. " " .. msg,
        vim.log.levels.WARN
      )
    end
  end)
end

util.isNeovide = function()
  return vim.g.neovide
end

util.mergeLists = function(...)
  local arglen = #{...}
  local touched = {}
  local merged = {}

  if arglen > 2 then
    for _, tbl in pairs({...}) do
      print(table.unpack(tbl))
      merged = util.mergeLists(merged, tbl)
    end

    return merged
  else
    for _, tbl in pairs({...}) do
      for _, item in pairs(tbl) do
        if touched[item] ~= true then
          touched[item] = true
          table.insert(merged, item)
        end
      end
    end
  end

  return merged
end

return util
