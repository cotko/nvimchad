local SF = require "custom.functions.shared"

local initialGuiFontSize = -1
local defaultGuiFontSize = 14
local defaultGuiFontName = 'Monospace'

function ParseGuiFontOrGetDefault(str)
  local font = defaultGuiFontName
  local size = defaultGuiFontSize

  if str ~= nil and string.find(str, ":") ~= nil then

    local eqIndex = string.find(str, '=')

    if eqIndex ~= nil then
      str = string.sub(str, eqIndex + 1)
    end

    local match = string.gmatch(str .. "", "[^:]+")

    font = match()
    size = tonumber(string.gmatch(match(), "%d+")())

  end

  return {
    font = font,
    size = size,
  }
end

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
    local variant = 1
    local ran, guiFont = pcall(vim.api.nvim_get_var, 'GuiFont')

    if ran==false then
      ran, guiFont = pcall(vim.api.nvim_command, 'set guifont')

      if ran == false then
        return
      end

      guiFont = vim.o.guifont
      variant = 2

    end

    local parsedFont = ParseGuiFontOrGetDefault(guiFont)

    local font = parsedFont.font
    local size = parsedFont.size

    if initialGuiFontSize == -1 then
      initialGuiFontSize = size
    end

    local newSize
    if reset then
      newSize = initialGuiFontSize
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

    local newGuiFont = font .. ":h" .. newSize

    if variant == 1 then
      vim.cmd('GuiFont! ' .. newGuiFont)
    else
      vim.o.guifont = newGuiFont
      -- vim.cmd('set guifont=' .. newGuiFont)
    end
  end,
}
