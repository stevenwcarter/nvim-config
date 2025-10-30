-- Generate and load coverage using cargo llvm-cov
vim.api.nvim_create_user_command("CoverageRust", function()
  if vim.bo.filetype == "rust" then
    local project_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    if not project_root or project_root == "" then project_root = vim.loop.cwd() end

    local coverage_report = project_root .. "/lcov.info"

    vim.notify("🔍 Generating coverage with cargo llvm-cov...", vim.log.levels.INFO)

    vim.fn.jobstart("cargo llvm-cov --lcov --output-path " .. coverage_report, {
      cwd = project_root,
      stdout_buffered = true,
      stderr_buffered = true,
      on_exit = function(_, code)
        vim.schedule(function()
          if code == 0 then
            require("coverage").load_lcov(coverage_report, true)
            vim.notify("✅ Coverage generated and loaded", vim.log.levels.INFO)
          else
            vim.notify("❌ cargo llvm-cov failed (" .. code .. ")", vim.log.levels.ERROR)
          end
        end)
      end,
    })
  else
    require("coverage").load(true)
  end
end, { desc = "Generate & load Rust coverage (cargo llvm-cov)" })

-- 🧠 Load-only version (no regeneration)
vim.api.nvim_create_user_command("CoverageRustLoad", function()
  local project_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if not project_root or project_root == "" then project_root = vim.loop.cwd() end

  local coverage_report = project_root .. "/lcov.info"

  if vim.fn.filereadable(coverage_report) == 1 then
    require("coverage").load_lcov(coverage_report, true)
    vim.notify("📊 Loaded coverage from " .. coverage_report)
  else
    vim.notify("⚠️ No lcov.info found at " .. coverage_report, vim.log.levels.WARN)
  end
end, { desc = "Load existing Rust coverage (lcov.info)" })

return {
  {
    "andythigpen/nvim-coverage",
    optional = true, -- merge with astrocommunity import
    opts = function(_, opts)
      -- Disable auto reload to avoid rerunning coverage every save
      opts.auto_reload = false

      -- 🚫 Wipe out the default Rust config completely first
      opts.lang = opts.lang or {}
      opts.lang.rust = {
        coverage_file = "lcov.info",
        commands = {
          -- ✅ Only run cargo llvm-cov, nothing else
          generate = "cargo llvm-cov --lcov --output-path lcov.info",
        },
      }

      return opts
    end,
  },
}
