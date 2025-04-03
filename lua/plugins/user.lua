local function diagnostic_goto(dir, severity)
  local go = vim.diagnostic["goto_" .. (dir and "next" or "prev")]
  if type(severity) == "string" then severity = vim.diagnostic.severity[severity] end
  return function() go { severity = severity } end
end

vim.opt.conceallevel = 2

vim.cmd [[syntax match htmlComment /<!--\zs.*\ze-->/ conceal]]
-- vim.cmd [[syntax region htmlComment start=<!-- end=--> contained]]
-- vim.cmd [[highlight link htmlComment Comment"]]

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function() require("lsp_signature").setup() end,
  -- },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  -- {
  --   "goolord/alpha-nvim",
  --   opts = function(_, opts)
  --     -- customize the dashboard header
  --     opts.section.header.val = {
  --       " █████  ███████ ████████ ██████   ██████",
  --       "██   ██ ██         ██    ██   ██ ██    ██",
  --       "███████ ███████    ██    ██████  ██    ██",
  --       "██   ██      ██    ██    ██   ██ ██    ██",
  --       "██   ██ ███████    ██    ██   ██  ██████",
  --       " ",
  --       "    ███    ██ ██    ██ ██ ███    ███",
  --       "    ████   ██ ██    ██ ██ ████  ████",
  --       "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
  --       "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
  --       "    ██   ████   ████   ██ ██      ██",
  --     }
  --     return opts
  --   end,
  -- },

  -- You can disable default plugins as follows:
  -- { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  -- {
  --   "L3MON4D3/LuaSnip",
  --   config = function(plugin, opts)
  --     require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom luasnip configuration such as filetype extend or custom snippets
  --     local luasnip = require "luasnip"
  --     luasnip.filetype_extend("javascript", { "javascriptreact" })
  --   end,
  -- },

  -- {
  --   "windwp/nvim-autopairs",
  --   config = function(plugin, opts)
  --     require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom autopairs configuration such as custom rules
  --     local npairs = require "nvim-autopairs"
  --     local Rule = require "nvim-autopairs.rule"
  --     local cond = require "nvim-autopairs.conds"
  --     npairs.add_rules(
  --       {
  --         Rule("$", "$", { "tex", "latex" })
  --           -- don't add a pair if the next character is %
  --           :with_pair(cond.not_after_regex "%%")
  --           -- don't add a pair if  the previous character is xxx
  --           :with_pair(
  --             cond.not_before_regex("xxx", 3)
  --           )
  --           -- don't move right when repeat character
  --           :with_move(cond.none()
  --           -- don't delete if the next character is xx
  --           :with_del(cond.not_after_regex "xx")
  --           -- disable adding a newline when you press <cr>
  --           :with_cr(cond.none()),
  --       },
  --       -- disable for .vim files, but it work for another filetypes
  --       Rule("a", "a", "-vim")
  --     )
  --   end,
  -- },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          -- this mapping will only be set in buffers with an LSP attached
          ["<leader>lj"] = {
            diagnostic_goto(true),
            desc = "Jump to next diagnostic",
          },
          ["<leader>lp"] = {
            diagnostic_goto(false),
            desc = "Jump to prev diagnostic",
          },
          ["<leader>tc"] = {
            "<Cmd>Coverage<CR>",
            desc = "Load coverage",
          },
          ["<leader>ts"] = {
            "<Cmd>CoverageSummary<CR>",
            desc = "Show coverage summary",
          },
          ["<leader>lt"] = {
            function() require("todo-comments").jump_next() end,
            desc = "Jump to next TODO",
          },
          ["<leader>lT"] = {
            function() require("todo-comments").jump_prev() end,
            desc = "Jump to prev TODO",
          },
        },
      },
    },
  },
  -- {
  --   "antonk52/bad-practices.nvim",
  --   opts = {},
  -- },
  {
    "m4xshen/smartcolumn.nvim",
    event = { "InsertEnter", "User AstroFile" },
    opts = {
      scope = "window",
      colorcolumn = "100",
      disabled_filetypes = { "alpha", "neo-tree", "ministarter", "help", "text", "markdown", "oil", "octo" },
    },
  },
  {
    "nvim-telekasten/calendar-vim",
  },
  {
    "renerocksai/telekasten.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {
      home = vim.fn.expand "~/zettelkasten",
    },
  },
  {
    "RRethy/vim-illuminate",
    event = "User AstroFile",
    opts = {},
    config = function(_, opts) require("illuminate").configure(opts) end,
    specs = {
      {
        "catppuccin",
        optional = true,
        ---@type CatppuccinOptions
        opts = { integrations = { illuminate = true } },
      },
    },
  },
  taplo = {
    filetypes = { "toml" },
    -- IMPORTANT: this is required for taplo LSP to work in non-git repositories
    root_dir = require("lspconfig.util").root_pattern("*.toml", ".git"),
  },
}
