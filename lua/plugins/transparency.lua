-- Configuration de la transparence pour voir l'image de fond d'iTerm2
return {
  -- Note: Configuration tokyonight désactivée, remplacée par onedark

  -- Plugin de transparence supplémentaire pour plus de contrôle
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    config = function()
      require("transparent").setup({
        groups = {
          "Normal",
          "NormalNC",
          "Comment",
          "Constant",
          "Special",
          "Identifier",
          "Statement",
          "PreProc",
          "Type",
          "Underlined",
          "Todo",
          "String",
          "Function",
          "Conditional",
          "Repeat",
          "Operator",
          "Structure",
          "LineNr",
          "NonText",
          "SignColumn",
          "CursorLineNr",
          "EndOfBuffer",
        },
        extra_groups = {
          -- Groupes supplémentaires à rendre transparents
          "NormalFloat", -- Fenêtres flottantes
          "FloatBorder", -- Bordures des fenêtres flottantes
          
          -- Cursor et ligne courante
          "CursorLine",
          "CursorLineNr", 
          "CursorColumn",
          
          -- Status line
          "StatusLine",
          "StatusLineNC",
          
          -- Telescope
          "TelescopeNormal",
          "TelescopeBorder",
          "TelescopePromptNormal",
          "TelescopePromptBorder",
          "TelescopeResultsNormal",
          "TelescopeResultsBorder",
          "TelescopePreviewNormal",
          "TelescopePreviewBorder",
          
          
          -- Autres
          "WhichKeyFloat",
          "LspFloatWinNormal",
          "DiagnosticFloatingError",
          "DiagnosticFloatingWarn",
          "DiagnosticFloatingInfo",
          "DiagnosticFloatingHint",
          
          -- Tabs
          "TabLine",
          "TabLineFill",
          "TabLineSel",
          
          -- WinBar
          "WinBar",
          "WinBarNC",
          
          -- Visual selection
          "Visual",
          "VisualNOS",
        },
        exclude_groups = {}, -- Groupes à exclure de la transparence
      })
      
      -- Activer la transparence au démarrage
      require("transparent").clear_prefix("BufferLine")

    end,
  },

  -- Configuration de lualine avec le thème One Dark transparent
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Créer un thème One Dark transparent
      local onedark_transparent = {
        normal = {
          a = { bg = "NONE", fg = "#61afef", gui = "bold" }, -- Bleu One Dark
          b = { bg = "NONE", fg = "#56b6c2" }, -- Cyan One Dark
          c = { bg = "NONE", fg = "#abb2bf" }, -- Gris clair One Dark
        },
        insert = {
          a = { bg = "NONE", fg = "#98c379", gui = "bold" }, -- Vert One Dark
          b = { bg = "NONE", fg = "#56b6c2" },
          c = { bg = "NONE", fg = "#abb2bf" },
        },
        visual = {
          a = { bg = "NONE", fg = "#c678dd", gui = "bold" }, -- Violet One Dark
          b = { bg = "NONE", fg = "#56b6c2" },
          c = { bg = "NONE", fg = "#abb2bf" },
        },
        replace = {
          a = { bg = "NONE", fg = "#e06c75", gui = "bold" }, -- Rouge One Dark
          b = { bg = "NONE", fg = "#56b6c2" },
          c = { bg = "NONE", fg = "#abb2bf" },
        },
        command = {
          a = { bg = "NONE", fg = "#e5c07b", gui = "bold" }, -- Jaune One Dark
          b = { bg = "NONE", fg = "#56b6c2" },
          c = { bg = "NONE", fg = "#abb2bf" },
        },
        inactive = {
          a = { bg = "NONE", fg = "#5c6370" }, -- Gris sombre One Dark
          b = { bg = "NONE", fg = "#5c6370" },
          c = { bg = "NONE", fg = "#5c6370" },
        },
      }
      
      opts.options = opts.options or {}
      opts.options.theme = onedark_transparent
      opts.options.component_separators = { left = "", right = "" }
      opts.options.section_separators = { left = "", right = "" }
      
      return opts
    end,
  },
}