return {
  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      local fg = "#ffffff"
      local fg_dim = "#888888"
      local theme = {
        normal   = { a = { fg = fg,     bg = "NONE", gui = "bold" }, b = { fg = fg,     bg = "NONE" }, c = { fg = fg,     bg = "NONE" } },
        insert   = { a = { fg = fg,     bg = "NONE", gui = "bold" }, b = { fg = fg,     bg = "NONE" }, c = { fg = fg,     bg = "NONE" } },
        visual   = { a = { fg = fg,     bg = "NONE", gui = "bold" }, b = { fg = fg,     bg = "NONE" }, c = { fg = fg,     bg = "NONE" } },
        replace  = { a = { fg = fg,     bg = "NONE", gui = "bold" }, b = { fg = fg,     bg = "NONE" }, c = { fg = fg,     bg = "NONE" } },
        command  = { a = { fg = fg,     bg = "NONE", gui = "bold" }, b = { fg = fg,     bg = "NONE" }, c = { fg = fg,     bg = "NONE" } },
        inactive = { a = { fg = fg_dim, bg = "NONE"               }, b = { fg = fg_dim, bg = "NONE" }, c = { fg = fg_dim, bg = "NONE" } },
      }
      return {
        options = {
          theme = theme,
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "diagnostics",
              colored = false,
              symbols = { error = "E ", warn = "W ", info = "I ", hint = "H " },
            },
          },
          lualine_x = {},
          lualine_y = { "location" },
          lualine_z = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
      }
    end,
  },

  -- Colorizer: highlight hex/rgb/hsl colors
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = false,
        RRGGBBAA = true,
        css = true,
        css_fn = true,
        mode = "background",
      },
    },
  },
}
