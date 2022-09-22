local fonts = {}
local gui_font_variant = nil

local initial_gui_font_size = -1
local default_gui_font_size = 14
local default_gui_font_name = 'RobotoMono Nerd Font'

function fonts.parseGuiFontOrGetDefault(str)
  local font = default_gui_font_name
  local size = default_gui_font_size

  if str ~= nil and string.find(str, ":") ~= nil then

    local eqIndex = string.find(str, '=')

    if eqIndex ~= nil then
      str = string.sub(str, eqIndex + 1)
    end

    local match = string.gmatch(str .. "", "[^:]+")

    font = match()
    size = tonumber(string.gmatch(match(), "%d+")())

  end

  if initial_gui_font_size == -1 then
    initial_gui_font_size = size
  end

  return {
    font = font,
    size = size,
    initialGuiFontSize = initial_gui_font_size,
  }
end

fonts.getGuiFontSetVariant = function ()
  if gui_font_variant == nil then
    local ran, _ = pcall(vim.api.nvim_get_var, 'GuiFont')
    if ran==false then
      ran, _ = pcall(vim.api.nvim_command, 'set guifont')
      if ran ~= false then
        gui_font_variant = 2
      end
    else
      gui_font_variant = 1
    end
  end

  return gui_font_variant
end

fonts.getGuiFont = function()
  local variant = fonts.getGuiFontSetVariant()

  if variant == nil then
    fonts.warn('Can not get guifont')
    return nil
  end

  local guiFont
  if variant == 1 then
    _, guiFont= pcall(vim.api.nvim_get_var, 'GuiFont')
  else
    guiFont = vim.o.guifont
  end

  return fonts.parseGuiFontOrGetDefault(guiFont)
end

fonts.setGuiFont = function(fontName, fontSize)
  local newGuiFont = fontName .. ":h" .. fontSize
  local variant = fonts.getGuiFontSetVariant()

  if variant == nil then
    fonts.warn('Can not set guifont')
    return
  end

  if variant == 1 then
    vim.cmd('GuiFont! ' .. newGuiFont)
  else
    vim.o.guifont = newGuiFont
    -- vim.cmd('set guifont=' .. newGuiFont)
  end
end

fonts.setNewGuiFont = function(fontName)
  local current = fonts.getGuiFont()
  if current == nil then
    return
  end
  fonts.setGuiFont(fontName, current.size)
end

fonts.getFonts = function()
  local nerd_fonts = {}
  local fonts_out = vim.fn.system([[
    fc-list \
       | grep -i nerd | grep -i complete | cut -d':' -f2 \
       | awk -F'[,]+' '{for (i=1;i<=NF;i++) {printf "%s\n",$i;}}' \
       | awk '{$1=$1;print}' \
       | sort | uniq
  ]])

  for font in fonts_out:gmatch("[^\r\n]+") do
    -- filter out invalid mplus stuff
    if string.sub(font, 1, 3) ~= 'M+ ' then
      table.insert(nerd_fonts, font)
    end
  end

  return nerd_fonts
end

return fonts
