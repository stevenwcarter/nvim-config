if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
return {
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    config = function()
      -- Setup orgmode
      require("orgmode").setup {
        org_agenda_files = "~/iCloudDrive/Personal/orgfiles/**/*",
        org_default_notes_file = "~/iCloudDrive/Personal/orgfiles/refile.org",
        org_capture_templates = {
          r = {
            description = "Repo",
            template = "* [[%x][%(return string.match('%x', '([^/]+)$'))]]%?",
            target = "~/iCloudDrive/Personal/orgfiles/repos.org",
          },
        },
      }

      -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
      -- add ~org~ to ignore_install
      -- require('nvim-treesitter.configs').setup({
      --   ensure_installed = 'all',
      --   ignore_install = { 'org' },
      -- })
    end,
  },
  {
    "nvim-orgmode/telescope-orgmode.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-orgmode/orgmode",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension "orgmode"

      -- vim.keymap.set("n", "<leader>or", require("telescope").extensions.orgmode.refile_heading)
      -- vim.keymap.set("n", "<leader>of", require("telescope").extensions.orgmode.search_headings)
      -- vim.keymap.set("n", "<leader>ol", require("telescope").extensions.orgmode.insert_link)
    end,
  },
}
