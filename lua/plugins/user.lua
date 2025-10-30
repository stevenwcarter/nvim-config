-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

vim.opt.scrolloff = 10

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "vtsls" then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end
  end,
})

local function diagnostic_goto(dir, severity)
  local go = vim.diagnostic["goto_" .. (dir and "next" or "prev")]
  if type(severity) == "string" then severity = vim.diagnostic.severity[severity] end
  return function() go { severity = severity } end
end

local Terminal = require("toggleterm.terminal").Terminal
local float_term = Terminal:new { direction = "float", hidden = true }

vim.keymap.set("n", "<C-\\>", function() float_term:toggle() end)
vim.keymap.set("t", "<C-\\>", function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", true)
  float_term:toggle()
end)

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        enabled = true,
        preset = {
          header = table.concat({
            " █████  ███████ ████████ ██████   ██████ ",
            "██   ██ ██         ██    ██   ██ ██    ██",
            "███████ ███████    ██    ██████  ██    ██",
            "██   ██      ██    ██    ██   ██ ██    ██",
            "██   ██ ███████    ██    ██   ██  ██████ ",
            "",
            "███    ██ ██    ██ ██ ███    ███",
            "████   ██ ██    ██ ██ ████  ████",
            "██ ██  ██ ██    ██ ██ ██ ████ ██",
            "██  ██ ██  ██  ██  ██ ██  ██  ██",
            "██   ████   ████   ██ ██      ██",
          }, "\n"),
        },
      },
    },
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
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
          ["<leader>Tr"] = { desc = "Rust coverage" },
          ["<leader>Trr"] = {
            "<Cmd>CoverageRust<CR>",
            desc = "Generate and load Rust coverage",
          },
          ["<leader>Trl"] = {
            "<Cmd>CoverageRustLoad<CR>",
            desc = "Load Rust coverage",
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
  -- {
  --   "renerocksai/telekasten.nvim",
  --   dependencies = { "nvim-telescope/telescope.nvim" },
  --   opts = {
  --     home = vim.fn.expand "~/zettelkasten",
  --   },
  -- },
  -- {
  --   "stevearc/conform.nvim",
  --   event = { "BufWritePre" },
  --   cmd = { "ConformInfo" },
  --   keys = {
  --     {
  --       -- Customize or remove this keymap to your liking
  --       "<leader>F",
  --       function() require("conform").format { async = true, lsp_fallback = true } end,
  --       mode = "",
  --       desc = "Format buffer",
  --     },
  --   },
  --   -- This will provide type hinting with LuaLS
  --   ---@module "conform"
  --   ---@type conform.setupOpts
  --   opts = {
  --     -- Define your formatters
  --     formatters_by_ft = {
  --       lua = { "stylua" },
  --       -- python = { "isort", "black" },
  --       markdown = { "prettierd" },
  --       -- javascript = { "prettierd", "prettier", stop_after_first = true },
  --     },
  --     -- Set default options
  --     default_format_opts = {
  --       lsp_format = "fallback",
  --     },
  --     -- Set up format-on-save
  --     format_on_save = { timeout_ms = 1500, lsp_fallback = true },
  --     -- Customize formatters
  --     formatters = {
  --       shfmt = {
  --         prepend_args = { "-i", "2" },
  --       },
  --     },
  --   },
  --   init = function()
  --     -- If you want the formatexpr, here is the place to set it
  --     vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  --   end,
  -- },
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
