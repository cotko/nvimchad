return {
  override_options = {
    ensure_installed = {
      "bash",
      "c",
      "c_sharp",
      "cmake",
      "cpp",
      "css",
      "dockerfile",
      "fish",
      "go",
      "hcl",
      "html",
      "java",
      "javascript",
      "jsonc",
      "kotlin",
      "latex",
      "lua",
      "markdown",
      "php",
      "python",
      "sql",
      "toml",
      "typescript",
      "yaml",
      "query",
    },
    playground = {
      enable = true,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = 'o',
        toggle_hl_groups = 'i',
        toggle_injected_languages = 't',
        toggle_anonymous_nodes = 'a',
        toggle_language_display = 'I',
        focus_language = 'f',
        unfocus_language = 'F',
        update = 'R',
        goto_node = '<cr>',
        show_help = '?',
      },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<CR>",
        node_incremental = "<CR>",
        scope_incremental = "gsi",
        node_decremental = "<BS>",
      },
    },
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          -- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap
          ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        },
        -- You can choose the select mode (default is charwise 'v')
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          ['@function.outer'] = 'V', -- linewise
          ['@class.outer'] = '<c-v>', -- blockwise
        },
        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to include preceding xor succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap`.
        include_surrounding_whitespace = false,
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>s"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>S"] = "@parameter.inner",
        },
      },
      -- move = {
      -- 	enable = true,
      -- 	set_jumps = true, -- whether to set jumps in the jumplist
      -- 	goto_next_start = {
      -- 		["]m"] = "@function.outer",
      -- 		["]]"] = "@class.outer",
      -- 	},
      -- 	goto_next_end = {
      -- 		["]M"] = "@function.outer",
      -- 		["]["] = "@class.outer",
      -- 	},
      -- 	goto_previous_start = {
      -- 		["[m"] = "@function.outer",
      -- 		["[["] = "@class.outer",
      -- 	},
      -- 	goto_previous_end = {
      -- 		["[M"] = "@function.outer",
      -- 		["[]"] = "@class.outer",
      -- 	},
      -- },
      lsp_interop = {
        enable = true,
        border = 'none',
        peek_definition_code = {
          ["<leader>lf"] = "@function.outer",
          ["<leader>lF"] = "@class.outer",
        },
      },
    },
  },
}
