local SF = require "custom.functions.shared"

return {
  toggleLineNumbering = function()
    local nl = vim.o.relativenumber and vim.o.number
    vim.o.number = not nl
    vim.o.relativenumber = not nl
  end,

  toggleHlSearch = function()
    vim.o.hlsearch = not vim.o.hlsearch
  end,

  toggleIndents = function(global)
    local stop = 2
    local expandtab = true
    local target
    if global then
      target = vim.o
    else
      target = vim.bo
    end

    if target.ts == 2 and target.expandtab then
      stop = 4
    elseif target.ts == 4 and target.expandtab then
      stop = 4
      expandtab = false
    end

    target.ts = stop
    target.sts = stop
    target.sw = stop
    target.expandtab = expandtab

    print("identing set:", (expandtab and (stop .. " spaces") or "tabs") .. (global and " globally" or ""))
  end,

  adjustFontSize = function(step, reset)
   local parsedFont = SF.getGuiFont()

    if parsedFont == nil then
      return
    end

    local font = parsedFont.font
    local size = parsedFont.size

    local newSize
    if reset then
      newSize = parsedFont.initialGuiFontSize
    else
      newSize = size + step
    end

    if newSize == size then
      return
    end

    if newSize < 8 then
      SF.warn("Will not go below 8")
      return
    end

    SF.setGuiFont(font, newSize)
  end,
}
