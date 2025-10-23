-- AstroNvim diagnostics script
-- This script helps identify common issues with AstroNvim configuration

local REPORT_FILE = "/tmp/astronvim_diagnostics.json"

-- Common error patterns to suppress in notifications
local ERROR_PATTERNS = {
  "not a real value for ensure_installed",
  "position_params",
  "offset_encoding",
  "failed to get treesitter parser",
  "treesitter query error"
}

-- Original notify function for capturing notifications
local orig_notify = vim.notify
local all_notifications = {}

-- Function to check if message contains an error pattern
local function matches_error_pattern(msg)
  if type(msg) ~= "string" then return false end

  for _, pattern in ipairs(ERROR_PATTERNS) do
    if msg:match(pattern) then
      return true
    end
  end
  return false
end

-- Intercept notifications
vim.notify = function(msg, level, opts)
  -- Record the notification
  table.insert(all_notifications, {
    msg = msg,
    level = level,
    opts = opts,
    is_error = (level == vim.log.levels.ERROR or matches_error_pattern(msg))
  })

  -- Suppress known errors
  if matches_error_pattern(msg) then
    return
  end

  return orig_notify(msg, level, opts)
end

-- Run diagnostics
local function run_diagnostics()
  local report = {
    nvim_version = vim.version(),
    astronvim_version = require("version").version or "unknown",
    timestamp = os.time(),
    notifications = all_notifications,
    errors = {},
    warnings = {},
    loaded_plugins = {},
    checks = {}
  }

  -- Check if critical plugins are loaded
  local critical_plugins = {
    "nvim-treesitter",
    "mason",
    "mason-lspconfig",
    "lazy",
    "astrocore"
  }

  for _, plugin in ipairs(critical_plugins) do
    local is_loaded = package.loaded[plugin] ~= nil
    report.loaded_plugins[plugin] = is_loaded

    if not is_loaded then
      table.insert(report.warnings, {
        type = "plugin_not_loaded",
        plugin = plugin
      })
    end
  end

  -- Check Treesitter
  report.checks.treesitter = {}
  if package.loaded["nvim-treesitter"] then
    local ok, ts_info = pcall(function()
      local data = {}

      -- Check configs
      data.has_configs = package.loaded["nvim-treesitter.configs"] ~= nil

      -- Check parsers
      if package.loaded["nvim-treesitter.parsers"] then
        local parsers = require("nvim-treesitter.parsers")
        data.available_parsers = parsers.available_parsers()

        -- Check core parsers
        local core_parsers = {"c", "lua", "vim", "vimdoc", "query"}
        data.core_parsers_status = {}

        for _, parser in ipairs(core_parsers) do
          data.core_parsers_status[parser] = parsers.has_parser(parser)
          if not parsers.has_parser(parser) then
            table.insert(report.errors, {
              type = "missing_core_parser",
              parser = parser
            })
          end
        end
      end

      return data
    end)

    if ok then
      report.checks.treesitter = ts_info
    else
      report.checks.treesitter.error = tostring(ts_info)
      table.insert(report.errors, {
        type = "treesitter_check_failed",
        error = tostring(ts_info)
      })
    end
  end

  -- Check Mason
  report.checks.mason = {}
  if package.loaded["mason"] then
    local ok, mason_info = pcall(function()
      local data = {}

      -- Check registry
      data.has_registry = package.loaded["mason-registry"] ~= nil

      -- Check installed packages
      if package.loaded["mason-registry"] then
        local registry = require("mason-registry")
        data.installed_packages = {}

        for _, pkg in ipairs(registry.get_installed_packages()) do
          table.insert(data.installed_packages, pkg.name)
        end
      end

      return data
    end)

    if ok then
      report.checks.mason = mason_info
    else
      report.checks.mason.error = tostring(mason_info)
      table.insert(report.errors, {
        type = "mason_check_failed",
        error = tostring(mason_info)
      })
    end
  end

  -- Extract error notifications
  for _, notif in ipairs(all_notifications) do
    if notif.is_error then
      table.insert(report.errors, {
        type = "error_notification",
        msg = notif.msg,
        level = notif.level
      })
    end
  end

  -- Save report
  local file = io.open(REPORT_FILE, "w")
  if file then
    file:write(vim.json.encode(report))
    file:close()
    print("Diagnostic report written to " .. REPORT_FILE)
  else
    print("Failed to write diagnostic report to " .. REPORT_FILE)
  end

  -- Print summary
  print("\n=== AstroNvim Diagnostic Summary ===")
  print("NeoVim version: " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch)

  if #report.errors > 0 then
    print("\nErrors (" .. #report.errors .. "):")
    for i, err in ipairs(report.errors) do
      print("  " .. i .. ". " .. err.type .. ": " .. (err.msg or err.error or ""))
    end
  else
    print("\nNo errors detected!")
  end

  if #report.warnings > 0 then
    print("\nWarnings (" .. #report.warnings .. "):")
    for i, warn in ipairs(report.warnings) do
      print("  " .. i .. ". " .. warn.type .. ": " .. (warn.plugin or ""))
    end
  else
    print("\nNo warnings detected!")
  end

  print("\nSteps to fix common issues:")
  print("1. Run ':Lazy sync' to update and synchronize plugins")
  print("2. Run ':MasonUpdate' to update Mason packages")
  print("3. Run ':TSUpdate' to update all Treesitter parsers")
  print("\nFor more details, check " .. REPORT_FILE)

  return report
end

-- Run diagnostics after a short delay to allow plugins to load
vim.defer_fn(function()
  run_diagnostics()

  -- Exit if in headless mode
  if vim.g.headless then
    vim.cmd("quit")
  end
end, 1000)

-- Return a message for interactive use
return "Running AstroNvim diagnostics... Results will appear shortly."
