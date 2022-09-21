local cmd = vim.api.nvim_create_user_command
local SF = require "custom.functions.shared"

local fonts = nil

local function getFonts ()
  if fonts == nil then
    local fontsOut = vim.fn.system([[
      fc-list | grep -i nerd | grep -i complete | cut -d':' -f2 \
       | awk -F'[,]+' '{for (i=1;i<=NF;i++) {printf "%s\n",$i;}}' \
       | awk '{$1=$1;print}' \
       | sort | uniq
    ]])

    fonts = {}
    for font in fontsOut:gmatch("[^\r\n]+") do
      -- filter out invalid mplus stuff
      if string.sub(font, 1, 3) ~= 'M+ ' then
        table.insert(fonts, font)
      end
    end
  end

  return fonts
end

cmd(
  "SelectGuiFont",
  function (args)
    local availableFonts = getFonts()

    vim.ui.select(
      availableFonts,
      { prompt = 'select' },
      function (item, idx)
        SF.setNewGuiFont(item)
      end
    )
    --  fc-list | grep -i nerd | grep -i complete | cut -d':' -f2 | sort | uniq

    --  fc-list | grep -i nerd | grep -i complete | cut -d':' -f2 |
    --    -- split ones with comma into new lines
    --    awk -F'[,]+' '{for (i=1;i<=NF;i++) {printf "%s\n",$i;}}' |
    --    -- trim lines
    --    awk '{$1=$1;print}' |
    --    sort | uniq

  end,
  { nargs = "*", desc = "Select and set GUI Font from available font list" }
)

-- rather do this in fileptye.lua
-- autocmd(
--   { "FileType" },
--   {
--     pattern = "json",
--     callback = function() 
--       vim.cmd "set ft=jsonc syntax=jsonc"
--     end
--   }
-- )
