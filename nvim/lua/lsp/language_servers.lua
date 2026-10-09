
-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require'lspconfig'.html.setup {
  capabilities = capabilities
}
require'lspconfig'.cssls.setup {
  capabilities = capabilities
}
require'lspconfig'.lua_ls.setup{}

