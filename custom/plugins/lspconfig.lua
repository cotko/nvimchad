local lspsettings = require "custom.plugins.lsp"
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"
local lspmasonmappings = require"custom.plugins.lsp_mason_map"
local masonconfig = require"custom.overrides.mason"

for _, server in ipairs(masonconfig.ensure_installed) do
  local lsp = lspmasonmappings.mason_lsp_map[server]

  if lsp ~= nil then
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = lspsettings[lsp],
    }
  end
end
