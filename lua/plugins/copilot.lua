return {
  -- ──────────────── GitHub Copilot Completion ────────────────
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      -- Disable <Tab> integration to avoid conflicts with other completion systems
      vim.g.copilot_no_tab_map = true

      -- Custom accept keymap (your original preference)
      vim.keymap.set("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

      -- Optional: Useful navigation bindings (uncomment if desired)
      -- vim.keymap.set("i", "<C-]>", "copilot#Next()", { silent = true, expr = true })
      -- vim.keymap.set("i", "<C-[>", "copilot#Previous()", { silent = true, expr = true })
    end,

    specs = {
      {
        "AstroNvim/astrocore",
        opts = {
          options = {
            g = {
              ai_accept = function()
                local suggestion = vim.fn["copilot#GetDisplayedSuggestion"]()
                if suggestion.text ~= "" then
                  vim.api.nvim_feedkeys(vim.fn["copilot#Accept"] "<CR>", "i", true)
                  return true
                end
              end,
            },
          },
        },
      },
    },
  },

  -- ──────────────── Copilot Chat / Agent Mode ────────────────
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- reuse your Copilot auth
      { "nvim-lua/plenary.nvim" },
    },
    cmd = { "CopilotChat", "CopilotChatToggle" },
    build = "make tiktoken", -- token counting; safe to remove if desired

    opts = {
      model = "gpt-4.1", -- default: use Copilot's best model
      auto_insert_mode = true, -- smooth editing experience
      window = {
        layout = "vertical", -- nicer split UX
        width = 0.45,
      },
      picker = {
        provider = "snacks",
      },
    },

    keys = {
      -- Toggle chat UI
      {
        "<leader>aC",
        function() require("CopilotChat").toggle() end,
        desc = "Copilot Chat (toggle)",
      },

      -- Ask a question about the current buffer or selection
      {
        "<leader>aA",
        function() require("CopilotChat").ask "Explain this" end,
        mode = { "n", "v" },
        desc = "Ask Copilot about selection/buffer",
      },

      -- View diff & apply edits
      {
        "<leader>aD",
        function() require("CopilotChat").diff() end,
        desc = "Show Copilot edit diff",
      },
    },
  },
}

-- return {
--   {
--     "github/copilot.vim",
--     config = function()
--       -- Optional: Set up any custom Copilot configurations here
--       vim.g.copilot_no_tab_map = true
--       vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
--       -- vim.api.nvim_set_keymap("i", "<C-]>", "copilot#Next()", { silent = true, expr = true })
--       -- vim.api.nvim_set_keymap("i", "<C-[>", "copilot#Previous()", { silent = true, expr = true })
--       -- vim.api.nvim_set_keymap("i", "<Tab>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
--       -- vim.api.nvim_set_keymap("i", "<Nul>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
--     end,
--     specs = {
--       {
--         "AstroNvim/astrocore",
--         opts = {
--           options = {
--             g = {
--               -- set the ai_accept function
--               ai_accept = function()
--                 local suggestion = vim.fn["copilot#GetDisplayedSuggestion"]()
--                 if suggestion.text ~= "" then
--                   vim.api.nvim_feedkeys(vim.fn["copilot#Accept"] "<CR>", "i", true)
--                   return true
--                 end
--                 -- if require("copilot.suggestion").is_visible() then
--                 --   require("copilot.suggestion").accept()
--                 --   return true
--                 -- end
--               end,
--             },
--           },
--         },
--       },
--     },
--   },
--   {
--     "CopilotC-Nvim/CopilotChat.nvim",
--     dependencies = {
--       { "github/copilot.vim" },
--       { "nvim-lua/plenary.nvim", branch = "master" },
--     },
--     build = "make tiktoken",
--     opts = {},
--   },
-- }
