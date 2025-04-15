-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      i = {
        ["[["] = {
          function() require("telekasten").insert_link() end,
          desc = "Insert zettelkasten link",
        },
      },
      n = {
        -- ["<Leader>o"] = { desc = "Orgmode" },
        -- ["<Leader>or"] = {
        --   function() require("telescope").extensions.orgmode.refile_heading() end,
        --   desc = "Refile heading",
        -- },
        -- ["<Leader>of"] = {
        --   function() require("telescope").extensions.orgmode.search_headings() end,
        --   desc = "Search headings",
        -- },
        -- ["<Leader>ol"] = {
        --   function() require("telescope").extensions.orgmode.insert_link() end,
        --   desc = "Insert link",
        -- },
        ["<Leader>z"] = {
          function() require("telekasten").panel() end,
          desc = "Zettelkasten panel",
        },
        ["<Leader>zs"] = {
          function() require("telekasten").search_notes() end,
          desc = "Search notes",
        },
        ["<Leader>zd"] = {
          function() require("telekasten").goto_today() end,
          desc = "Daily note",
        },
        ["<Leader>zw"] = {
          function() require("telekasten").goto_thisweek() end,
          desc = "Weekly note",
        },
        ["<Leader>zz"] = {
          function() require("telekasten").follow_link() end,
          desc = "Follow link",
        },
        ["<Leader>zn"] = {
          function() require("telekasten").new_note() end,
          desc = "New note",
        },
        ["<Leader>zt"] = {
          function() require("telekasten").new_templated_note() end,
          desc = "New templated note",
        },
        ["<Leader>zc"] = {
          function() require("telekasten").show_calendar() end,
          desc = "Show calendar",
        },
        ["<Leader>zb"] = {
          function() require("telekasten").show_backlinks() end,
          desc = "Show backlinks",
        },
        ["<Leader>zI"] = {
          function() require("telekasten").insert_img_link() end,
          desc = "Insert image link",
        },
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
    },
  },
}
