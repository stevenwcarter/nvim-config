return {
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      -- Preserve any other servers or defaults
      opts.servers = opts.servers or {}

      opts.servers.vtsls = vim.tbl_deep_extend("force", opts.servers.vtsls or {}, {
        on_attach = function(client, bufnr)
          -- Disable formatting
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false

          -- Optional: call the default on_attach so other AstroLSP mappings still work
          local astrolsp = require "astrolsp"
          if astrolsp.on_attach then astrolsp.on_attach(client, bufnr) end
        end,
        settings = {
          typescript = {
            format = { enable = false },
          },
          javascript = {
            format = { enable = false },
          },
        },
      })

      return opts
    end,
  },
}
