-- AI Refactor keybindings
-- Uses refactor.ts from ai-scripts repo to perform AI-powered refactoring
-- Write a comment at the end of the file with instructions, then press Space+<key>

return {
  {
    "ai-refactor",
    dir = vim.fn.expand("~/Documents/Github/ai-scripts"),
    lazy = false,
    config = function()
      local refactor_script = vim.fn.expand("~/Documents/Github/ai-scripts/refactor.ts")
      local active_jobs = {}

      -- Helper function to run refactor with a specific model
      local function refactor_with_model(model)
        return function()
          local filepath = vim.fn.expand("%:p")
          vim.cmd("write")

          vim.notify(string.format("Refactoring with model '%s'...", model), vim.log.levels.INFO)

          -- Run refactor script synchronously
          local cmd = {
            "bun", refactor_script, filepath, model
          }

          local job_id = vim.fn.jobstart(cmd, {
            on_exit = function(j_id, exit_code)
              active_jobs[j_id] = nil
              if exit_code == 0 then
                vim.schedule(function()
                  vim.cmd("checktime") -- Reload file if changed
                  vim.notify("Refactor complete!", vim.log.levels.INFO)
                end)
              else
                vim.schedule(function()
                  vim.notify(string.format("Refactor failed with code %d", exit_code), vim.log.levels.ERROR)
                end)
              end
            end,
            on_stdout = function(_, data)
              if data and #data > 0 then
                vim.schedule(function()
                  for _, line in ipairs(data) do
                    if line ~= "" then
                      print(line)
                    end
                  end
                end)
              end
            end,
            on_stderr = function(_, data)
              if data and #data > 0 then
                vim.schedule(function()
                  for _, line in ipairs(data) do
                    if line ~= "" then
                      vim.notify(line, vim.log.levels.WARN)
                    end
                  end
                end)
              end
            end,
          })

          if job_id > 0 then
            active_jobs[job_id] = {
              model = model,
              file = vim.fn.fnamemodify(filepath, ":t"),
              started = os.time()
            }
          end
        end
      end

      -- Command to list active refactor jobs
      vim.api.nvim_create_user_command("RefactorJobs", function()
        if vim.tbl_count(active_jobs) == 0 then
          vim.notify("No active refactor jobs", vim.log.levels.INFO)
          return
        end

        local lines = { "Active refactor jobs:" }
        for job_id, info in pairs(active_jobs) do
          local elapsed = os.time() - info.started
          table.insert(lines, string.format("  [%d] %s - %s (%ds)", job_id, info.model, info.file, elapsed))
        end
        vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO)
      end, {})

      -- GPT-5.1 models
      vim.keymap.set("n", "<leader>ag", refactor_with_model("g"), {
        desc = "Refactor with GPT-5.1 (medium)"
      })
      vim.keymap.set("n", "<leader>aG", refactor_with_model("G"), {
        desc = "Refactor with GPT-5.1 (high)"
      })

      -- Gemini-3 models
      vim.keymap.set("n", "<leader>ai", refactor_with_model("i"), {
        desc = "Refactor with Gemini-3 (medium)"
      })
      vim.keymap.set("n", "<leader>aI", refactor_with_model("I"), {
        desc = "Refactor with Gemini-3 (high)"
      })

      -- Claude Sonnet models
      vim.keymap.set("n", "<leader>as", refactor_with_model("s"), {
        desc = "Refactor with Sonnet-4.5 (medium)"
      })
      vim.keymap.set("n", "<leader>aS", refactor_with_model("S"), {
        desc = "Refactor with Sonnet-4.5 (high)"
      })

      -- Claude Opus models
      vim.keymap.set("n", "<leader>ao", refactor_with_model("o"), {
        desc = "Refactor with Opus-4 (medium)"
      })
      vim.keymap.set("n", "<leader>aO", refactor_with_model("O"), {
        desc = "Refactor with Opus-4 (high)"
      })

      -- xAI Grok models
      vim.keymap.set("n", "<leader>ax", refactor_with_model("x"), {
        desc = "Refactor with Grok-4 (medium)"
      })
      vim.keymap.set("n", "<leader>aX", refactor_with_model("X"), {
        desc = "Refactor with Grok-4 (high)"
      })
    end,
  },
}
