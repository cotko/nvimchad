local fileFunctions = require "custom.functions.files"

local size = 40
local resizeStep = 10

local function resize(wider)
  if wider then
    size = size + resizeStep
  else
    size = size - resizeStep
  end

  vim.cmd("NvimTreeResize " .. size)
end

local nvimtreeMappings = {
  {
    key = { "o" },
    action = "edit_no_picker",
    desc = "open a file or folder; root will cd to the above directory",
  },
  {
    key = { "<CR>", "O" },
    action = "edit",
    desc = "same as (edit) but with with window picker",
  },
  {
    key = { "cd", "<2-RightMouse>" },
    action = "cd",
    desc = "cd in the directory under the cursor",
  },
  {
    key = "<C-v>",
    action = "vsplit",
    desc = "open the file in a vertical split",
  },
  {
    key = "<C-h>",
    action = "split",
    desc = "open the file in a horizontal split",
  },
  {
    key = { "T", "<C-t>" },
    action = "tabnew",
    desc = "open the file in a new tab",
  },
  {
    key = "<",
    action = "prev_sibling",
    desc = "navigate to the previous sibling of current file/directory",
  },
  {
    key = ">",
    action = "next_sibling",
    desc = "navigate to the next sibling of current file/directory",
  },
  {
    key = "p",
    action = "parent_node",
    desc = "move cursor to the parent directory",
  },
  {
    key = "P",
    action = "close_node",
    desc = "close current opened directory or parent",
  },
  {
    key = "<Tab>",
    action = "preview",
    desc = "open the file as a preview (keeps the cursor in the tree)",
  },
  -- {
  --   key = "K",
  --   action = "first_sibling",
  --   desc = "navigate to the first sibling of current file/directory",
  -- },
  -- {
  --   key = "J",
  --   action = "last_sibling",
  --   desc = "navigate to the last sibling of current file/directory",
  -- },
  {
    key = "I",
    action = "toggle_git_ignored",
    desc = "toggle visibility of files/folders hidden via |git.ignore| option",
  },
  {
    key = "i",
    action = "toggle_dotfiles",
    desc = "toggle visibility of dotfiles via |filters.dotfiles| option",
  },
  -- {
  --   key = "U",
  --   action = "toggle_custom",
  --   desc = "toggle visibility of files/folders hidden via |filters.custom| option",
  -- },
  {
    key = "r",
    action = "refresh",
    desc = "refresh the tree",
  },
  {
    key = "ma",
    action = "create",
    desc = "add a file; leaving a trailing `/` will add a directory",
  },
  {
    key = "md",
    action = "remove",
    desc = "delete a file (will prompt for confirmation)",
  },
  {
    key = "mD",
    action = "trash",
    desc = "trash a file via |trash| option",
  },
  {
    key = { "mr", "mm" },
    action = "rename",
    desc = "rename a file",
  },
  {
    key = "mR",
    action = "full_rename",
    desc = "rename a file and omit the filename on input",
  },
  {
    key = "mx",
    action = "cut",
    desc = "add/remove file/directory to cut clipboard",
  },
  {
    key = "mc",
    action = "better_copy",
    action_cb = fileFunctions.better_copy,
    desc = "copy file",
  },
  {
    key = "mC",
    action = "copy",
    desc = "add/remove file/directory to copy clipboard",
  },
  {
    key = "mp",
    action = "paste",
    desc = "paste from clipboard; cut clipboard has precedence over copy; will prompt for confirmation",
  },
  {
    key = "yy",
    action = "copy_name",
    desc = "copy name to system clipboard",
  },
  -- {
  --   key = "yp",
  --   action = "copy_path",
  --   desc = "copy relative path to system clipboard",
  -- },
  {
    key = "ya",
    action = "copy_absolute_path",
    desc = "copy absolute path to system clipboard",
  },
  -- {
  --   key = "[c",
  --   action = "prev_git_item",
  --   desc = "go to next git item",
  -- },
  -- {
  --   key = "]c",
  --   action = "next_git_item",
  --   desc = "go to prev git item",
  -- },
  -- {
  --   key = "-",
  --   action = "dir_up",
  --   desc = "navigate up to the parent directory of the current file/directory",
  -- },
  {
    key = "so",
    action = "system_open",
    desc = "open a file with default system application or a folder with default file manager, using |system_open| option",
  },
  {
    key = "f",
    action = "live_filter",
    desc = "live filter nodes dynamically based on regex matching.",
  },
  {
    key = "F",
    action = "clear_live_filter",
    desc = "clear live filter",
  },
  -- {
  --   key = "q",
  --   action = "close",
  --   desc = "close tree window",
  -- },
  {
    key = "ca",
    action = "collapse_all",
    desc = "collapse the whole tree",
  },
  {
    key = "ea",
    action = "expand_all",
    desc = "expand the whole tree, stopping after expanding |actions.expand_all.max_folder_discovery| folders; this might hang neovim for a while if running on a big folder",
  },
  -- {
  --   key = "S",
  --   action = "search_node",
  --   desc = "prompt the user to enter a path and then expands the tree to match the path",
  -- },
  {
    key = ".",
    action = "run_file_command",
    desc = "enter vim command mode with the file the cursor is on",
  },
  {
    key = "<C-k>",
    action = "toggle_file_info",
    desc = "toggle a popup with file infos about the file under the cursor",
  },
  {
    key = "?",
    action = "toggle_help",
    desc = "toggle help",
  },
  {
    key = { "=", "+"},
    action = "resize_increase",
    action_cb = function () resize(true) end,
    desc = "resize up",
  },
  {
    key = { "-" },
    action = "resize_decrease",
    action_cb = function () resize(false) end,
    desc = "resize down",
  },

   -- will remove default actions
  { key = "<2-RightMouse>", action = "" },
}

return {
  view = {
    width = size,
    hide_root_folder = false,
    number = true,
    relativenumber = true,
    adaptive_size = false,
    mappings = {
      custom_only = true,
      list = nvimtreeMappings,
    },
  },
  git = {
    enable = true,
    ignore = false,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
  live_filter = {
    always_show_folders = false,
  },
  update_focused_file = {
     -- disable annoying file focusing when related buffer is focuced
     enable = false,
     update_cwd = false,
  },
}
