return {

  setup_lsp = function(attach, capabilities)
    local lspconfig = require "lspconfig"

    -- lspservers with default config
    local servers = { "html", "tsserver", "bashls", "cssls", "eslint", "java_language_server" }

    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        on_attach = attach,
        capabilities = capabilities,
      }
    end
  end
}
