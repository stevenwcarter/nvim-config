return {
  {
    "github/copilot.vim",
    config = function()
      -- Optional: Set up any custom Copilot configurations here
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
      -- vim.api.nvim_set_keymap("i", "<C-]>", "copilot#Next()", { silent = true, expr = true })
      -- vim.api.nvim_set_keymap("i", "<C-[>", "copilot#Previous()", { silent = true, expr = true })
      -- vim.api.nvim_set_keymap("i", "<Tab>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
      -- vim.api.nvim_set_keymap("i", "<Nul>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end,
    specs = {
      {
        "AstroNvim/astrocore",
        opts = {
          options = {
            g = {
              -- set the ai_accept function
              ai_accept = function()
                local suggestion = vim.fn["copilot#GetDisplayedSuggestion"]()
                if suggestion.text ~= "" then
                  vim.api.nvim_feedkeys(vim.fn["copilot#Accept"] "<CR>", "i", true)
                  return true
                end
                -- if require("copilot.suggestion").is_visible() then
                --   require("copilot.suggestion").accept()
                --   return true
                -- end
              end,
            },
          },
        },
      },
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {},
  },
}
