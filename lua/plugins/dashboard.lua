return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("dashboard").setup({
      theme = "doom",
      config = {
        header = {
          "",
          "",
          "",
          "",
          "",
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
          "",
          "",
        },
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
            desc = "Config              ",
            key = "c",
            action = "edit ~/.config/nvim/init.lua",
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
