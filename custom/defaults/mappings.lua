local chadmappings = require('core.mappings')
local fn_mapping = require 'custom.functions.mappings'

local disable_all_chad_mappings = {}
for _, chmappings in pairs(chadmappings) do
  for mode, keys in pairs(chmappings) do
    if not disable_all_chad_mappings[mode] then
      disable_all_chad_mappings[mode] = {}
    end
    local skeys = (type(keys) == 'table' and keys) or {}
    for k, _ in pairs(skeys) do
      disable_all_chad_mappings[mode][k] = ''
    end
  end
end

return {
  disabled = disable_all_chad_mappings,

  general = {
    n = {
      -- switch between windows
      ['<A-h>'] = { '<C-w>h', ' window left' },
      ['<A-l>'] = { '<C-w>l', ' window right' },
      ['<A-j>'] = { '<C-w>j', ' window down' },
      ['<A-k>'] = { '<C-w>k', ' window up' },


      ['<C-y>'] = { '<cmd> %y+ <CR>', '  copy whole file' },

      ['<F11>'] = { fn_mapping.toggleLineNumbering, '   toggle line number' },
      ['<F4>'] = { fn_mapping.toggleHlSearch, '   toggle highlight search' },
      ['<F9>'] = { fn_mapping.toggleIndents, '   toggle between indenting' },
      ['<leader><F9>'] = {
        function() fn_mapping.toggleIndents(true) end,
        '   toggle between indenting' 
      },

      ['<leader>g'] = { '<cmd> :e# <CR>', 'goto prev buffer' },

      ['<C-+>'] = { function() fn_mapping.adjustFontSize(1) end, '+  increase font size' },
      ['<C-S-+>'] = { function() fn_mapping.adjustFontSize(1) end, '+  increase font size' },
      ['<C-->'] = { function() fn_mapping.adjustFontSize(-1) end, '+  decrease font size' },
      ['<C-0>'] = { function() fn_mapping.adjustFontSize(0, true) end, '+  reset font size' },

      ['<F3>'] = { ":echo expand('%:p')<CR>", "  show file location" },
      ['<leader>d'] = { '<cmd> Kwbd <CR>', "  close buffer" },

      -- FORMATTING
      ["<leader>fj"] = {
        function ()
          vim.api.nvim_command "%!jq . -"
        end,
        "format whole buffer to JSON"
      },
      ["<leader>flj"] = {
        function ()
          vim.api.nvim_command ".!jq . -"
        end,
        "format whole current line to JSON"
      },
      ["<leader>fb"] = {
        function ()
          vim.api.nvim_command "%!b64dec . -"
        end,
        "decode whole buffer from from B64 + optionally json format it"
      },
      ["<leader>flb"] = {
        function ()
          vim.api.nvim_command ".!b64dec . -"
        end,
        "decode whole current line from B64 + optionally json format it"
      },

      -- TODO: figure this out!
      -- ["<leader>p"] = { "\"_dP", "Paste deleted" },


      -- from CHAD
      ["<ESC>"] = { "<cmd> noh <CR>", "no highlight" },
      ["<C-s>"] = { "<cmd> w <CR>", "save file" },
      ["<leader>uu"] = { "<cmd> :NvChadUpdate <CR>", "update nvchad" },
      ["<leader>tt"] = {
        function()
          require("base46").toggle_theme()
        end,
        "toggle theme",
      },
      -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
      -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
      -- empty mode is same as using <cmd> :map
      -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
      ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
      ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    },
    i = {
      ['<F3>'] = { ":echo expand('%:p')<CR>", "  show file location" },
    },

    v = {
      ["<leader>fj"] = {
        function ()
          vim.api.nvim_command "'<,'>!jq"
        end,
        "format selection to JSON"
      },
      ["<leader>fb"] = {
        function ()
          vim.api.nvim_command "'<,'>!b64dec"
        end,
        "decode selection from B64 + optionally json format it"
      },

      -- from CHAD
      ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
      ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    },

    x = {

      -- from CHAD
      ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
      ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
      -- Don't copy the replaced text after pasting in visual mode
      -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
      ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', opts = { silent = true } },
    },
  },

  nvimtree = {
    n = {
      -- toggle
      ['<leader>`'] = { '<cmd> NvimTreeToggle <CR>', '   toggle file browser' },
      ['<leader><Tab>'] = { '<cmd> NvimTreeToggle <CR>', '   toggle file browser' },
      ["<M-e>"] = { "<cmd> NvimTreeFocus <CR>", "   focus nvimtree" }
    }
  },

  telescope = {
    n = {
      ["<leader>e"] = { "<cmd> Telescope buffers <CR>", "  find buffers" },
      ["<leader>cs"] = { "<cmd> Telescope git_status <CR>", "  git status" },
    },
  },

  trouble = {
    n = {
      ["<leader>aw"] = {
        "<cmd>Trouble document_diagnostics<cr>",
        " document diagnostics",
      },
      ["<leader>ad"] = {
        "<cmd>Trouble workspace_diagnostics<cr>",
        " workspace diagnostics ",
      },
    }
  },

  lspconfig = {
    n = {
      -- nvim 0.8.x
      ["<leader>lf"] = {
        function()
          vim.lsp.buf.format { async = true }
        end,
        "lsp formatting",
      },

      ["<leader>ac"] = {
        function()
          vim.lsp.buf.code_action()
        end,
        "   lsp code_action",
      },

      ["<leader>rn"] = {
         function()
            require("nvchad_ui.renamer").open()
         end,
         "   lsp rename",
      },
      ["gD"] = {
        function()
          vim.lsp.buf.declaration()
        end,
        "lsp declaration",
      },

      ["gd"] = {
        function()
          vim.lsp.buf.definition()
        end,
        "lsp definition",
      },

      ["K"] = {
        function()
          vim.lsp.buf.hover()
        end,
        "lsp hover",
      },

      ["gi"] = {
        function()
          vim.lsp.buf.implementation()
        end,
        "lsp implementation",
      },

      ["<leader>ls"] = {
        function()
          vim.lsp.buf.signature_help()
        end,
        "lsp signature_help",
      },

      ["<leader>lD"] = {
        function()
          vim.lsp.buf.type_definition()
        end,
        "lsp definition type",
      },
      ["gr"] = {
        function()
          vim.lsp.buf.references()
        end,
        "lsp references",
      },

      ["<leader>ld"] = {
        function()
          vim.diagnostic.open_float()
        end,
        "floating diagnostic",
      },

      ["[d"] = {
        function()
          vim.diagnostic.goto_prev()
        end,
        "goto prev",
      },

      ["d]"] = {
        function()
          vim.diagnostic.goto_next()
        end,
        "goto_next",
      },

      ["<leader>lq"] = {
        function()
          vim.diagnostic.setloclist()
        end,
        "diagnostic setloclist",
      },
      -- ["<leader>wa"] = {
      --   function()
      --     vim.lsp.buf.add_workspace_folder()
      --   end,
      --   "add workspace folder",
      -- },

      -- ["<leader>wr"] = {
      --   function()
      --     vim.lsp.buf.remove_workspace_folder()
      --   end,
      --   "remove workspace folder",
      -- },

      -- ["<leader>wl"] = {
      --   function()
      --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      --   end,
      --   "list workspace folders",
      -- },

    },
  },


  -- from CHAD
  whichkey = {
    plugin = true,

    n = {
      ["<leader>w"] = {
        function()
          vim.cmd "WhichKey"
        end,
        "which-key all keymaps",
      },
    },
  },
  comment = {
    plugin = true,

    -- toggle comment in both modes
    n = {
      ["<leader>/"] = {
        function()
          require("Comment.api").toggle.linewise.current()
        end,
        "toggle comment",
      },
    },

    v = {
      ["<leader>/"] = {
        "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
        "toggle comment",
      },
    },
  }
}
