-- Customize Treesitter

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    treesitter = {
      enabled = function(lang, bufnr) return not require("astrocore.buffer").is_large(bufnr) end,
      highlight = true,
      indent = true,
      ensure_installed = { "lua", "vim", "vimdoc", "gitcommit", "git_rebase", "diff" },
      auto_install = true,
    },
  },
}
