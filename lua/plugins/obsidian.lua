-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

local wk = require "which-key"
wk.add {
  { "<leader>o", group = "Obsidian", desc = "Obsidian" },
  { "<leader>ob", "<Cmd>ObsidianBacklinks<CR>", desc = "Backlinks" },
  { "<leader>oD", "<Cmd>ObsidianDailies<CR>", desc = "Search recent daily notes" },
  { "<leader>od", "<Cmd>ObsidianToday<CR>", desc = "Open daily note" },
  { "<leader>oY", "<Cmd>ObsidianYesterday<CR>", desc = "Open yesterday's daily note" },
  { "<leader>oT", "<Cmd>ObsidianTomorrow<CR>", desc = "Open tomorrow's daily note" },
  { "<leader>ot", "<Cmd>ObsidianTemplate<CR>", desc = "Open tomorrow's daily note" },
  { "<leader>oq", "<Cmd>ObsidianQuickSwitch<CR>", desc = "Quick switch" },
  { "<leader>ow", "<Cmd>ObsidianWorkspace<CR>", desc = "Switch workspace" },
}

return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = false,
  -- ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Documents/Personal",
        overrides = {
          notes_subdir = "0 - Inbox",
        },
      },
      {
        name = "work",
        path = "~/Documents/Bounteous",
        overrides = {
          notes_subdir = "0 - Inbox",
        },
      },
    },
    daily_notes = {
      folder = "Daily Log",
      date_format = "%Y-%m-%d",
      template = "Daily Template",
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    new_notes_location = "notes_subdir",
    templates = {
      folder = "Templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },
    mappings = {
      ["gf"] = {
        action = function() return require("obsidian").util.gf_passthrough() end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ["<leader>ch"] = {
        action = function() return require("obsidian").util.toggle_checkbox() end,
        opts = { buffer = true },
      },
      -- Smart action depending on context, either follow link or toggle checkbox.
      ["<cr>"] = {
        action = function() return require("obsidian").util.smart_action() end,
        opts = { buffer = true, expr = true },
      },
    },
    ---@param url string
    follow_url_func = function(url)
      vim.ui.open(url) -- need Neovim 0.10.0+
    end,
    open_notes_in = "vsplit",
    attachments = {
      img_folder = "Attachments",
    },
  },
}
