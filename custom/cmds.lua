local cmd = vim.api.nvim_create_user_command

cmd(
  "SelectGuiFont",
  function (args)
    print("aaaa" .. args.args)

    --  fc-list | grep -i nerd | grep -i complete | cut -d':' -f2 | sort | uniq

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
