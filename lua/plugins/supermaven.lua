-- Configuration personnalisée pour Supermaven avec couleurs grisées
return {
  {
    "supermaven-inc/supermaven-nvim",
    opts = {
      keymaps = {
        accept_suggestion = "<Tab>",
        clear_suggestion = "<C-]>",
        accept_word = "<C-j>",
      },
      ignore_filetypes = { 
        "bigfile", 
        "snacks_input", 
        "snacks_notif",
        -- Ajouter d'autres types de fichiers à ignorer si nécessaire
      },
      color = {
        suggestion_color = "#5c6370", -- Gris One Dark pour les suggestions
        cterm = 244,
      },
      log_level = "info", -- "off", "trace", "debug", "info", "warn", "error"
      disable_inline_completion = false, -- garder les suggestions inline
      disable_keymaps = false, -- garder les raccourcis par défaut
      condition = function()
        -- Désactiver dans certains contextes si nécessaire
        return false
      end,
    },
    config = function(_, opts)
      require("supermaven-nvim").setup(opts)
      
      -- Configurer explicitement les couleurs des suggestions après le setup
      vim.defer_fn(function()
        -- Couleur grisée pour les suggestions Supermaven
        vim.api.nvim_set_hl(0, "SupermavenSuggestion", {
          fg = "#5c6370",    -- Gris One Dark
          italic = true,     -- Italique pour différencier
          bg = "NONE",       -- Pas de fond
        })
        
        -- Alternative: utiliser les couleurs de commentaires mais plus claires
        vim.api.nvim_set_hl(0, "SupermavenInlineSuggestion", {
          fg = "#6c7682",    -- Gris légèrement plus clair
          italic = true,
          bg = "NONE",
        })
        
        -- Assurer que les suggestions sont visibles mais discrètes
        vim.api.nvim_set_hl(0, "CmpItemKindSupermaven", {
          fg = "#61afef",    -- Bleu One Dark pour l'icône
          bg = "NONE",
        })
      end, 100)
    end,
  },
}