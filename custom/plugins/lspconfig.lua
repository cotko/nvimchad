local lspsettings = require "custom.plugins.lsp"

return {

  setup_lsp = function(attach, capabilities)
    local lspconfig = require "lspconfig"

    -- lspservers with default config
    local servers = {
       "html",
       "tsserver",
       "bashls",
       "cssls",
       "eslint",
       "jsonls",
       "java_language_server",
       "pyright",
       "pylsp",
       "rust_analyzer",
    }

    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        on_attach = attach,
        capabilities = capabilities,
        settings = lspsettings[lsp],
      }
    end
  end
}
