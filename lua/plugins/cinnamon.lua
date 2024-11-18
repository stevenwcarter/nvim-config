if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "declancm/cinnamon.nvim",
  version = "*",
  event = "VeryLazy",
  opts = {
    disabled = false,
    keymaps = {
      basic = true,
      extra = true,
    },
    options = {
      max_delta = {
        line = 80,
        time = 600,
      },
    },
  },
}
