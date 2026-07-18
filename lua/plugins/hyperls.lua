return {
  -- Extend the AstroCore plugin options
  {
    "AstroNvim/astrocore",
    opts = {
      autocmds = {
        -- Define a new autocommand group (e.g., "HyprLangLSP")
        HyprLangLSP = {
          -- The list of autocommands in this group
          {
            -- The events that trigger the autocommand
            event = { "BufEnter", "BufWinEnter" },
            -- The patterns (file names/extensions) to match
            pattern = { "*.hl", "hypr*.conf" },
            -- A description for the autocommand
            desc = "Start hyprls language server",
            -- The callback function to execute
            callback = function(event)
              -- Check if the LSP is already attached for this buffer to prevent multiple starts
              local clients = vim.lsp.get_clients { bufnr = event.buf, name = "hyprlang" }
              if #clients == 0 then
                -- Optional: print for debugging
                -- print(string.format("starting hyprls for %s", vim.inspect(event)))
                vim.lsp.start {
                  name = "hyprlang",
                  cmd = { "hyprls" },
                  -- Using vim.fn.getcwd() is often fine, but for LSP it's better to find the project root.
                  -- AstroNvim's LSP utility or lspconfig's util is typically preferred for root_dir.
                  -- Since 'hyprls' is likely configured for a specific filetype/use case,
                  -- setting a simple root_dir like this might be acceptable, or you could
                  -- remove it if 'hyprls' handles root detection itself.
                  root_dir = vim.fn.getcwd(),
                }
              end
            end,
          },
        },
      },
    },
  },
}
