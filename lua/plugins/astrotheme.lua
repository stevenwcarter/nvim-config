return {
  -- {
  --   "astrotheme",
  --   opts = {
  --     style = {
  --       transparent = false, -- Bool value, toggles transparency.
  --     },
  --   },
  -- },
  {
    "olimorris/onedarkpro.nvim",
    lazy = true,
    opts = {
      options = {
        highlight_inactive_windows = true,
        transparency = false,
      },
    },
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = true,
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "tiagovla/tokyodark.nvim",
    lazy = true,
    opts = {
      transparent_background = true,
      terminal_colors = true,
    },
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    opts = {
      options = {
        transparent = true,
        module_default = false,
        modules = {
          aerial = true,
          cmp = true,
          ["dap-ui"] = true,
          dashboard = true,
          diagnostic = true,
          gitsigns = true,
          native_lsp = true,
          neotree = true,
          notify = true,
          symbol_outline = true,
          telescope = true,
          treesitter = true,
          whichkey = true,
        },
      },
      groups = { all = { NormalFloat = { link = "Normal" } } },
    },
  },
}
