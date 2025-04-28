-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.recipes.cache-colorscheme" },
  { import = "astrocommunity.recipes.auto-session-restore" },
  -- { import = "astrocommunity.recipes.heirline-nvchad-statusline" },
  { import = "astrocommunity.icon.mini-icons" },
  { import = "astrocommunity.recipes.astrolsp-no-insert-inlay-hints" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.recipes.ai" },
  { import = "astrocommunity.test.nvim-coverage" },
  -- { import = "astrocommunity.scrolling.satellite-nvim" },
  -- { import = "astrocommunity.terminal-integration.vim-tmux-yank" },
  -- { import = "astrocommunity.utility.hover-nvim" },
  { import = "astrocommunity.utility.nvim-toggler" },
  { import = "astrocommunity.utility.vim-fetch" },
  -- { import = "astrocommunity.code-runner.overseer-nvim" },
  { import = "astrocommunity.color.transparent-nvim" },
  -- { import = "astrocommunity.diagnostics.lsp_lines-nvim" },
  -- { import = "astrocommunity.media.codesnap-nvim" },
  -- { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  -- adds guides for jump shortcuts
  -- { import = "astrocommunity.workflow.precognition-nvim" },
  -- import/override with your plugins folder
}
