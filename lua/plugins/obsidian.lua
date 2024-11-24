-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

local wk = require "which-key"
wk.add {
  { "<leader>o", function() end, group = "Obsidian", desc = "Obsidian" },
  { "<leader>ob", "<Cmd>ObsidianBacklinks<CR>", desc = "Backlinks" },
  { "<leader>oD", "<Cmd>ObsidianDailies<CR>", desc = "Search recent daily notes" },
  { "<leader>od", "<Cmd>ObsidianToday<CR>", desc = "Open daily note" },
  { "<leader>oe", "<Cmd>ObsidianExtractNote<CR>", desc = "Extract note" },
  { "<leader>ol", "<Cmd>ObsidianLink<CR>", desc = "Links in quick list" },
  { "<leader>oL", "<Cmd>ObsidianLinks<CR>", desc = "Links in quick list" },
  { "<leader>on", "<Cmd>ObsidianNew<CR>", desc = "New note" },
  { "<leader>oN", "<Cmd>ObsidianNewFromTemplate<CR>", desc = "New note from template" },
  { "<leader>oY", "<Cmd>ObsidianYesterday<CR>", desc = "Open yesterday's daily note" },
  { "<leader>oT", "<Cmd>ObsidianTomorrow<CR>", desc = "Open tomorrow's daily note" },
  { "<leader>oo", "<Cmd>ObsidianTOC<CR>", desc = "TOC in quicklist" },
  { "<leader>op", "<Cmd>ObsidianPasteImg<CR>", desc = "Paste image for Obsidian" },
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
          notes_subdir = "0 - INBOX",
        },
      },
      {
        name = "work",
        path = "~/Documents/Bounteous",
        overrides = {
          notes_subdir = "0 - INBOX",
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
    -- Optional, customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", "")
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return suffix
    end,
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
