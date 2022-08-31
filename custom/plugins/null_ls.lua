local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

null_ls.setup {
  debug = false,
  sources = {

    -- b.formatting.deno_fmt,

    b.code_actions.gitsigns,

    b.formatting.prettier.with {
      filetypes = {
        "html", "markdown", "css", "js", "ts", "mjs", "mts"
      }
    },

    b.formatting.eslint,
    b.formatting.autopep8,
    -- b.formatting.spell,

    -- Lua
    b.formatting.stylua,

    -- Shell
    b.formatting.shfmt,
    b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

    -- cpp
    -- b.formatting.clang_format,
  }
}
