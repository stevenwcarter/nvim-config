-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

local wk = require "which-key"
wk.add {
  { "<leader>o", function() end, group = "Obsidian", desc = "Obsidian" },
  { "<leader>ob", "<Cmd>ObsidianBacklinks<CR>", desc = "Backlinks" },
  { "<leader>oD", "<Cmd>ObsidianDailies<CR>", desc = "Search recent daily notes" },
  { "<leader>od", "<Cmd>ObsidianToday<CR>", desc = "Open daily note" },
  { "<leader>oe", "<Cmd>ObsidianExtractNote<CR>", desc = "Extract note" },
  { "<leader>off", "<Cmd>ObsidianSearch<CR>", desc = "Search notes" },
  { "<leader>oft", "<Cmd>ObsidianTags<CR>", desc = "Search tags" },
  { "<leader>ol", "<Cmd>ObsidianLink<CR>", desc = "Links in quick list" },
  { "<leader>oL", "<Cmd>ObsidianLinks<CR>", desc = "Links in quick list" },
  { "<leader>on", "<Cmd>ObsidianNew<CR>", desc = "New note" },
  { "<leader>oN", "<Cmd>ObsidianNewFromTemplate<CR>", desc = "New note from template" },
  { "<leader>oY", "<Cmd>ObsidianYesterday<CR>", desc = "Open yesterday's daily note" },
  { "<leader>oT", "<Cmd>ObsidianTomorrow<CR>", desc = "Open tomorrow's daily note" },
  { "<leader>oo", "<Cmd>ObsidianTOC<CR>", desc = "TOC in quicklist" },
  { "<leader>o<CR>", "<Cmd>ObsidianOpen<CR>", desc = "TOC in quicklist" },
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
    -- Optional, configure additional syntax highlighting / extmarks.
    -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
    ui = {
      enable = true, -- set to false to disable all additional syntax features
      update_debounce = 200, -- update delay after a text change (in milliseconds)
      max_file_length = 5000, -- disable UI features for files with more than this many lines
      -- Define how various check-boxes are displayed
      checkboxes = {
        -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        ["x"] = { char = "", hl_group = "ObsidianDone" },
        [">"] = { char = "", hl_group = "ObsidianRightArrow" },
        ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
        ["!"] = { char = "", hl_group = "ObsidianImportant" },

        -- You can also add more custom ones...
      },
      -- Use bullet marks for non-checkbox lists.
      bullets = { char = "•", hl_group = "ObsidianBullet" },
      external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
      -- Replace the above with this if you don't have a patched font:
      -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
      reference_text = { hl_group = "ObsidianRefText" },
      highlight_text = { hl_group = "ObsidianHighlightText" },
      tags = { hl_group = "ObsidianTag" },
      block_ids = { hl_group = "ObsidianBlockID" },
      hl_groups = {
        -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
        ObsidianTodo = { bold = true, fg = "#f78c6c" },
        ObsidianDone = { bold = true, fg = "#89ddff" },
        ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
        ObsidianTilde = { bold = true, fg = "#ff5370" },
        ObsidianImportant = { bold = true, fg = "#d73128" },
        ObsidianBullet = { bold = true, fg = "#89ddff" },
        ObsidianRefText = { underline = true, fg = "#c792ea" },
        ObsidianExtLinkIcon = { fg = "#c792ea" },
        ObsidianTag = { italic = true, fg = "#66cc66" },
        ObsidianBlockID = { italic = true, fg = "#89ddff" },
        ObsidianHighlightText = { bg = "#75662e" },
      },
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
