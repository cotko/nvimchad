local present, mod = pcall(require, "null-ls")
if not present then return end

local b = mod.builtins

mod.setup {
  debug = false,
  sources = {
    b.code_actions.gitsigns,

    b.code_actions.eslint_d,
    b.diagnostics.eslint_d,
    b.formatting.eslint_d,
    b.formatting.prettier,
		b.diagnostics.tsc,

    b.formatting.jq,


    b.formatting.autopep8,
    b.diagnostics.flake8,
 		b.diagnostics.pylint,

    b.completion.luasnip,
    b.formatting.stylua,
    -- b.formatting.lua_format,
  }
}
