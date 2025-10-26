return {
  "saghen/blink.cmp",
  lazy = false,
  dependencies = {
    "rafamadriz/friendly-snippets",
    "zbirenbaum/copilot.lua",
    "giuxtaposition/blink-cmp-copilot",
    "mikavilpas/blink-ripgrep.nvim",
    "xzbdmw/colorful-menu.nvim",
  },

  version = "v0.*",
  opts = function()
    local has_colorful, colorful = pcall(require, "colorful-menu")
    
    return {
      keymap = {
        preset = "enter",  -- Changed from "super-tab" to "enter"
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide' },
        ['<C-y>'] = { 'select_and_accept' },

        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        ['<A-1>'] = { function(cmp) cmp.accept({ index = 1 }) end },
        ['<A-2>'] = { function(cmp) cmp.accept({ index = 2 }) end },
        ['<A-3>'] = { function(cmp) cmp.accept({ index = 3 }) end },
        ['<A-4>'] = { function(cmp) cmp.accept({ index = 4 }) end },
        ['<A-5>'] = { function(cmp) cmp.accept({ index = 5 }) end },
        ['<A-6>'] = { function(cmp) cmp.accept({ index = 6 }) end },
        ['<A-7>'] = { function(cmp) cmp.accept({ index = 7 }) end },
        ['<A-8>'] = { function(cmp) cmp.accept({ index = 8 }) end },
        ['<A-9>'] = { function(cmp) cmp.accept({ index = 9 }) end },
        ['<A-0>'] = { function(cmp) cmp.accept({ index = 10 }) end },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
        kind_icons = {
          Copilot = "",
          Text = '󰉿',
          Method = '󰊕',
          Function = '󰊕',
          Constructor = '󰒓',

          Field = '󰜢',
          Variable = '󰆦',
          Property = '󰖷',

          Class = '󱡠',
          Interface = '󱡠',
          Struct = '󱡠',
          Module = '󰅩',

          Unit = '󰪚',
          Value = '󰦨',
          Enum = '󰦨',
          EnumMember = '󰦨',

          Keyword = '󰻾',
          Constant = '󰏿',

          Snippet = '󱄽',
          Color = '󰏘',
          File = '󰈔',
          Reference = '󰬲',
          Folder = '󰉋',
          Event = '󱐋',
          Operator = '󰪚',
          TypeParameter = '󰬛',
        },
      },
      completion = {
        menu = {
          border = "single",
          draw = has_colorful and {
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                text = colorful.blink_components_text,
                highlight = colorful.blink_components_highlight,
              },
            },
          } or {
            columns = { { "kind_icon" }, { "label", gap = 1 } },
          }
        },
        documentation = {
          window = {
            border = "single",
          }
        }
      },
      signature = { window = { border = 'single' } },
      cmdline = { enabled = true },
      sources = {
        default = { "snippets", "lsp", "path", "buffer", "copilot", "ripgrep" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 100,
            async = true,
            transform_items = function(_, items)
              local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
              local kind_idx = #CompletionItemKind + 1
              CompletionItemKind[kind_idx] = "Copilot"
              for _, item in ipairs(items) do
                item.kind = kind_idx
              end
              return items
            end,
          },
          ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
            opts = {
              prefix_min_len = 3,
              backend = {
                context_size = 5,
                ripgrep = {
                  max_filesize = "1M",
                  additional_rg_options = {},
                },
              },
            },
          },
        },
      },
    }
  end,
  opts_extend = {
    "sources.default",
    "sources.providers",
  },
}