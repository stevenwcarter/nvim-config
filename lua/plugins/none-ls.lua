-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  opts = function(_, opts)
    -- opts variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    opts.root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile")

    local filtered_sources = {}
    for _, source in ipairs(opts.sources or {}) do
      -- Skip vtsls/prettier/prettierd for TS/TSX
      if
        not (
          (source.name == "prettierd" or source.name == "prettier" or source.name == "vtsls")
          and vim.tbl_contains({ "typescript", "typescriptreact" }, source.filetypes[1])
        )
      then
        table.insert(filtered_sources, source)
      end
    end

    opts.sources = filtered_sources

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

    -- Only insert new sources, do not replace the existing ones
    -- (If you wish to replace, use `opts.sources = {}` instead of the `list_insert_unique` function)
    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      -- require "none-ls.diagnostics.eslint_d",
      require "none-ls.formatting.eslint_d",
      require "none-ls.code_actions.eslint_d",
    })
    table.insert(
      opts.sources,
      require("none-ls.diagnostics.eslint_d").with {
        args = {
          "--no-warn-ignored", -- 👈 this silences the “File ignored” warnings
          "--format",
          "json",
          "--stdin",
          "--stdin-filename",
          "$FILENAME",
        },
      }
    )
  end,
}
