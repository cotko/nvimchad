local present, mod = pcall(require, "mason-lspconfig.mappings.server")
local fn_util = require('custom.functions.util')

if not present then
  fn_util.warn('Mason lsp config could not be loaded', 'lspconfig')

  return
end

local lspsettings = require "custom.plugins.lsp"
local lspconfig = require "lspconfig"
local masonconfig = require "custom.plugins.mason"
local nvchadlspcfg = require "plugins.configs.lspconfig"
local on_attach = nvchadlspcfg.on_attach
local capabilities = nvchadlspcfg.capabilities
local mason_lsp_map = mod.package_to_lspconfig

for _, server in ipairs(masonconfig.all_modules) do
  local lsp = mason_lsp_map[server]
  local skip = lsp == nil

  if not skip then
    print(lsp)
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = lspsettings[lsp],
    }
  end
end
