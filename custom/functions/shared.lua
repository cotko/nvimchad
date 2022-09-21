local has_notify, notify = pcall(require, "notify")

local guiFontVariant = nil

local functions = {}

local initialGuiFontSize = -1
local defaultGuiFontSize = 14
local defaultGuiFontName = 'RobotoMono Nerd Font'

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

  if initialGuiFontSize == -1 then
    initialGuiFontSize = size
  end

  return {
    font = font,
    size = size,
    initialGuiFontSize = initialGuiFontSize,
  }
end



functions.warn = function (msg)
  vim.schedule(function()
    if has_notify then
      notify(msg, vim.log.levels.WARN, { title = "NvimTree" })
    else
      vim.notify("[NvimTree] " .. msg, vim.log.levels.WARN)
    end
  end)
end

functions.isNeovide = function()
  return vim.g.neovide
end

functions.getGuiFontVariant = function ()
  if guiFontVariant == nil then
    local ran, _ = pcall(vim.api.nvim_get_var, 'GuiFont')
    if ran==false then
      ran, _ = pcall(vim.api.nvim_command, 'set guifont')
      if ran ~= false then
        guiFontVariant = 2
      end
    else
      guiFontVariant = 1
    end
  end

  return guiFontVariant
end

functions.getGuiFont = function()
  local variant = functions.getGuiFontVariant()

  if variant == nil then
    SF.warn('Can not get guifont')
    return nil
  end

  local guiFont
  if variant == 1 then
    _, guiFont= pcall(vim.api.nvim_get_var, 'GuiFont')
  else
    guiFont = vim.o.guifont
  end

  return ParseGuiFontOrGetDefault(guiFont)
end

functions.setGuiFont = function(fontName, fontSize)
  local newGuiFont = fontName .. ":h" .. fontSize
  local variant = functions.getGuiFontVariant()

  if variant == nil then
    functions.warn('Can not set guifont')
    return
  end

  if variant == 1 then
    vim.cmd('GuiFont! ' .. newGuiFont)
  else
    vim.o.guifont = newGuiFont
    -- vim.cmd('set guifont=' .. newGuiFont)
  end
end

functions.setNewGuiFont = function(fontName)
  local current = functions.getGuiFont()
  if current == nil then
    return
  end
  functions.setGuiFont(fontName, current.size)
end

return functions
