local F = require 'custom.functions'

local Term = {

  -- toggle in terminal mode
  ["<Space>i"] = {
    function()
      require("nvterm.terminal").toggle "float"
    end,
    "   toggle floating term",
  },

  ["<Space>h"] = {
    function()
      require("nvterm.terminal").toggle "horizontal"
    end,
    "   toggle horizontal term",
  },

  ["<Space>v"] = {
    function()
      require("nvterm.terminal").toggle "vertical"
    end,
    "   toggle vertical term",
  },

  -- ["<leader>d"] = { termcodes "<C-\\><C-N>", "   escape terminal mode" },

}

return {

  disabled = {
    n = {
      -- general
      ["<leader>x"] = '',

      -- switch between windows
      ['<C-h>'] = '',
      ['<C-l>'] = '',
      ['<C-j>'] = '',
      ['<C-k>'] = '',

      -- Copy all
      ['<C-c>'] = '',

      -- line numbers
      ['<leader>n'] = '',
      ['<leader>rn'] = '',

      -- termninal
      ["<A-i>"] = '',
      ["<leader>h"] = '',
      ["<leader>v"] = '',

      -- telescope
      ["<leader>fb"] = '',
      ["<leader>gt"] = '',
      ["<leader>b"] = '',

      -- lspconfig
      ["<leader>ca"] = '',
      ["<leader>ra"] = '',

      ["<leader>pt"] = '',
    },
    v = {
      ["<leader>fb"] = '',
    }
  },

  general = {
    n = {
      -- switch between windows
      ['<A-h>'] = { '<C-w>h', ' window left' },
      ['<A-l>'] = { '<C-w>l', ' window right' },
      ['<A-j>'] = { '<C-w>j', ' window down' },
      ['<A-k>'] = { '<C-w>k', ' window up' },


      ['<C-y>'] = { '<cmd> %y+ <CR>', '  copy whole file' },

      ['<F11>'] = { F.toggleLineNumbering, '   toggle line number' },
      ['<F4>'] = { F.toggleHlSearch, '   toggle highlight search' },
      ['<F9>'] = { F.toggleIndents, '   toggle between indenting' },
      ['<leader><F9>'] = { function() F.toggleIndents(true) end, '   toggle between indenting' },

      ['<leader>g'] = { '<cmd> :e# <CR>', 'goto prev buffer' },

      ['<C-+>'] = { function() F.adjustFontSize(1) end, '+  increase font size' },
      ['<C-S-+>'] = { function() F.adjustFontSize(1) end, '+  increase font size' },
      ['<C-->'] = { function() F.adjustFontSize(-1) end, '+  decrease font size' },
      ['<C-0>'] = { function() F.adjustFontSize(0, true) end, '+  reset font size' },

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

      -- nvim 0.8.x
      ["<leader>fm"] = {
        function()
          vim.lsp.buf.format { async = true }
        end,
        "lsp formatting",
      },

      ["<leader>p"] = { "\"_dP", "Paste deleted" },


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
    }
  },

  nvimtree = {
    n = {
      -- toggle
      ['<leader>`'] = { '<cmd> NvimTreeToggle <CR>', '   toggle file browser' },
      ['<leader><Tab>'] = { '<cmd> NvimTreeToggle <CR>', '   toggle file browser' },
      ["<M-e>"] = { "<cmd> NvimTreeFocus <CR>", "   focus nvimtree" }
    }
  },

  nvterm = {
    n = Term,
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

    },
  },
}
