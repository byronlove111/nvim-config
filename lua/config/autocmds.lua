-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Forcer la transparence après chargement du colorscheme
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- Supprimer les fonds de ces groupes pour la transparence
    local groups = {
      "Normal",
      "NormalNC",
      "SignColumn",
      "EndOfBuffer",
      "MsgArea",
      "NormalFloat",
      "FloatBorder",
      
      -- Supprimer les highlights bleus
      "CursorLine",
      "CursorLineNr",
      "CursorColumn",
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
      "TabLine",
      "TabLineFill",
      "TabLineSel",
      "WinBar",
      "WinBarNC",
    }
    
    for _, group in ipairs(groups) do
      vim.api.nvim_set_hl(0, group, { bg = "NONE" })
    end
    
    -- Restaurer les couleurs importantes après suppression des fonds
    vim.defer_fn(function()
      -- Suggestions Supermaven grisées
      vim.api.nvim_set_hl(0, "SupermavenSuggestion", {
        fg = "#5c6370",    -- Gris One Dark (couleur commentaires)
        italic = true,
        bg = "NONE",
      })
      
      vim.api.nvim_set_hl(0, "SupermavenInlineSuggestion", {
        fg = "#6c7682",    -- Gris légèrement plus clair
        italic = true,
        bg = "NONE",
      })
      
      -- Icône Supermaven en bleu
      vim.api.nvim_set_hl(0, "CmpItemKindSupermaven", {
        fg = "#61afef",    -- Bleu One Dark
        bg = "NONE",
      })
    end, 50)
  end,
})

-- Autocmd pour maintenir la transparence au démarrage
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Petit délai pour s'assurer que tout est chargé
    vim.defer_fn(function()
      -- Commandes pour supprimer tous les fonds
      local highlights = {
        "Normal",
        "NormalNC", 
        "SignColumn",
        "EndOfBuffer",
        "CursorLine",
        "CursorLineNr",
        "CursorColumn",
        "StatusLine",
        "StatusLineNC",
        "TabLine",
        "TabLineFill",
        "TabLineSel",
      }
      
      for _, hl in ipairs(highlights) do
        vim.cmd(string.format("highlight %s guibg=NONE ctermbg=NONE", hl))
      end
      
      -- Désactiver cursorline si elle est activée
      vim.opt.cursorline = false
      vim.opt.cursorcolumn = false
      
      -- Configurer les couleurs Supermaven
      vim.api.nvim_set_hl(0, "SupermavenSuggestion", {
        fg = "#5c6370",    -- Gris One Dark
        italic = true,
        bg = "NONE",
      })
      
      vim.api.nvim_set_hl(0, "SupermavenInlineSuggestion", {
        fg = "#6c7682",
        italic = true,
        bg = "NONE",
      })
    end, 100)
  end,
})
