local fnUtil = require "custom.functions.util"

local installed_on_system = {
  "autopep8",
  "eslint_d",
  "flake8",
  "lua-language-server",
  "luacheck",
  "prettier",
  "pylint",
  "pyright",
  "python-lsp-server",
  "rust-analyzer",
  "stylua",
  "typescript-language-server",
}

local ensure_lsps = {
  -- "jdtls", -- java

  "lua-language-server",

  "typescript-language-server",
  -- "deno",

  "eslint-lsp",
  -- "css-lsp",
  -- "html-lsp",
  -- "json-lsp",

  "python-lsp-server",
  -- "autopep8",

  -- "bash-language-server",

  -- "yamllint",
  -- "yaml-language-server",
  -- "ltex-ls",

  "rust-analyzer",

}

local ensure_linters = {
  "autopep8",
  "eslint_d",
  "flake8",
  "luacheck",
  "prettier",
  "pylint",
  "pyright",
  "stylua",
}

local ensure_installed = fnUtil.mergeLists(
  ensure_lsps,
  ensure_linters
)

local function getEnsuredWithoutSystem()
  local installed = {}
  local result = {}
  for _, mod in pairs(installed_on_system) do
    installed[mod] = true
  end
  for _, mod in pairs(ensure_installed) do
    if installed[mod] ~= true then
      table.insert(result, mod)
      installed[mod] = true
    end
  end

  return result
end

local function getAllModules ()
  local result = {}
  for _, mod in pairs(installed_on_system) do
    table.insert(result, mod)
  end
  for _, mod in pairs(getEnsuredWithoutSystem()) do
    table.insert(result, mod)
  end

  return result
end

return {
  all_modules = getAllModules(),
  lsps = ensure_lsps,
  linters = ensure_linters,
  cmd = nil,
  override_options = {
    ensure_installed = getEnsuredWithoutSystem(),
  },
}
