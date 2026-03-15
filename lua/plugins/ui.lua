return {
  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      local colors = {
        fg      = "#cdd6f4",
        fg_dim  = "#6c7086",
        green   = "#a6e3a1",
        mauve   = "#cba6f7",
        red     = "#f38ba8",
        yellow  = "#f9e2af",
      }
      local minimal = {
        normal   = { a = { fg = colors.fg,     bg = "NONE", gui = "bold" }, b = { fg = colors.fg,     bg = "NONE" }, c = { fg = colors.fg,     bg = "NONE" } },
        insert   = { a = { fg = colors.fg,     bg = "NONE", gui = "bold" }, b = { fg = colors.fg,     bg = "NONE" }, c = { fg = colors.fg,     bg = "NONE" } },
        visual   = { a = { fg = colors.fg,     bg = "NONE", gui = "bold" }, b = { fg = colors.fg,     bg = "NONE" }, c = { fg = colors.fg,     bg = "NONE" } },
        replace  = { a = { fg = colors.fg,     bg = "NONE", gui = "bold" }, b = { fg = colors.fg,     bg = "NONE" }, c = { fg = colors.fg,     bg = "NONE" } },
        command  = { a = { fg = colors.fg,     bg = "NONE", gui = "bold" }, b = { fg = colors.fg,     bg = "NONE" }, c = { fg = colors.fg,     bg = "NONE" } },
        inactive = { a = { fg = colors.fg_dim, bg = "NONE"               }, b = { fg = colors.fg_dim, bg = "NONE" }, c = { fg = colors.fg_dim,  bg = "NONE" } },
      }
      return {
        options = {
          theme = minimal,
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = { "diagnostics" },
          lualine_x = {},
          lualine_y = { "location" },
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
