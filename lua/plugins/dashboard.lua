return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- Calculate vertical padding to center the dashboard
    local header_art = {
      "  ██▒   █▓ ██▓ ███▄ ▄███▓",
      "▓██░   █▒▓██▒▓██▒▀█▀ ██▒",
      " ▓██  █▒░▒██▒▓██    ▓██░",
      "  ▒██ █░░░██░▒██    ▒██ ",
      "   ▒▀█░  ░██░▒██▒   ░██▒",
      "   ░ ▐░  ░▓  ░ ▒░   ░  ░",
      "   ░ ░░   ▒ ░░  ░      ░",
      "     ░░   ▒ ░░      ░   ",
      "      ░   ░         ░   ",
      "     ░                  ",
    }
    local center_items = 6
    local content_height = #header_art + 2 + (center_items * 2) -- header + spacing + center items
    local win_height = vim.fn.winheight(0)
    local padding = math.max(0, math.floor((win_height - content_height) / 2))

    local header = {}
    for _ = 1, padding do
      table.insert(header, "")
    end
    for _, line in ipairs(header_art) do
      table.insert(header, line)
    end
    table.insert(header, "")
    table.insert(header, "")

    vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#83a598" })

    require("dashboard").setup({
      theme = "doom",
      config = {
        header = header,
        center = {
          {
            icon = "  ",
            desc = "Find File           ",
            key = "f",
            action = "Telescope find_files",
          },
          {
            icon = "  ",
            desc = "Recent Files        ",
            key = "r",
            action = "Telescope oldfiles",
          },
          {
            icon = "  ",
            desc = "Find Text           ",
            key = "g",
            action = "Telescope live_grep",
          },
          {
            icon = "  ",
            desc = "File Explorer       ",
            key = "e",
            action = "Neotree toggle",
          },
          {
            icon = "  ",
            desc = "Quit                ",
            key = "q",
            action = "quit",
          },
        },
        footer = {},
      },
    })
  end,
}
