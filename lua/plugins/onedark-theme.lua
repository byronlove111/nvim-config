-- Configuration du thème One Dark Pro avec transparence
return {
  -- Remplacer tokyonight par onedark
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- Style du thème (darker, dark, cool, deep, warm, warmer, light)
      style = "darker", -- Le plus proche de One Dark Pro
      transparent = true, -- Activer la transparence
      term_colors = true, -- Support des couleurs terminal
      ending_tildes = false, -- Masquer les tildes en fin de buffer
      cmp_itemkind_reverse = false, -- Ordre normal des icônes
      
      -- Configuration des styles d'éléments
      code_style = {
        comments = "italic",
        keywords = "bold",
        functions = "none",
        strings = "none",
        variables = "none",
      },
      
      -- Configuration de la transparence
      highlights = {
        -- Éléments principaux transparents
        Normal = { bg = "NONE" },
        NormalNC = { bg = "NONE" },
        SignColumn = { bg = "NONE" },
        EndOfBuffer = { bg = "NONE" },
        
        -- Cursor et ligne courante
        CursorLine = { bg = "NONE" },
        CursorLineNr = { bg = "NONE" },
        CursorColumn = { bg = "NONE" },
        
        -- Status line transparente
        StatusLine = { bg = "NONE" },
        StatusLineNC = { bg = "NONE" },
        
        -- Fenêtres flottantes
        NormalFloat = { bg = "NONE" },
        FloatBorder = { bg = "NONE" },
        
        -- Telescope transparent
        TelescopeNormal = { bg = "NONE" },
        TelescopeBorder = { bg = "NONE" },
        TelescopePromptNormal = { bg = "NONE" },
        TelescopePromptBorder = { bg = "NONE" },
        TelescopeResultsNormal = { bg = "NONE" },
        TelescopeResultsBorder = { bg = "NONE" },
        TelescopePreviewNormal = { bg = "NONE" },
        TelescopePreviewBorder = { bg = "NONE" },
        
        
        -- Tabs transparents
        TabLine = { bg = "NONE" },
        TabLineFill = { bg = "NONE" },
        TabLineSel = { bg = "NONE" },
        
        -- Autres éléments UI
        WinBar = { bg = "NONE" },
        WinBarNC = { bg = "NONE" },
        WhichKeyFloat = { bg = "NONE" },
        
        -- Diagnostics flottants
        DiagnosticFloatingError = { bg = "NONE" },
        DiagnosticFloatingWarn = { bg = "NONE" },
        DiagnosticFloatingInfo = { bg = "NONE" },
        DiagnosticFloatingHint = { bg = "NONE" },
      },
      
      -- Couleurs personnalisées (optionnel)
      colors = {}, -- Utiliser les couleurs par défaut One Dark
      
      -- Diagnostic
      diagnostics = {
        darker = true, -- Couleurs de diagnostic plus sombres
        undercurl = true, -- Soulignements ondulés
        background = false, -- Pas de fond pour les diagnostics
      },
    },
    config = function(_, opts)
      require("onedark").setup(opts)
      require("onedark").load()
    end,
  },

  -- Désactiver tokyonight
  {
    "folke/tokyonight.nvim",
    enabled = false,
  },

  -- Configurer LazyVim pour utiliser onedark
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}