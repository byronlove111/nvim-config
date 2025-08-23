-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Raccourcis pour le formatage
local map = vim.keymap.set

-- Formater le fichier actuel manuellement
map("n", "<leader>cf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

-- Basculer le formatage automatique
map("n", "<leader>uf", function()
  if vim.g.autoformat then
    vim.g.autoformat = false
    vim.notify("Formatage automatique désactivé", vim.log.levels.INFO)
  else
    vim.g.autoformat = true
    vim.notify("Formatage automatique activé", vim.log.levels.INFO)
  end
end, { desc = "Toggle auto format" })

-- Basculer la transparence
map("n", "<leader>ut", function()
  require("transparent").toggle()
end, { desc = "Toggle transparency" })

-- Forcer la transparence complète (supprimer TOUT fond coloré)
map("n", "<leader>uT", function()
  local highlights = {
    "Normal", "NormalNC", "SignColumn", "EndOfBuffer", "MsgArea",
    "CursorLine", "CursorLineNr", "CursorColumn",
    "StatusLine", "StatusLineNC", 
    "TabLine", "TabLineFill", "TabLineSel",
    "NormalFloat", "FloatBorder",
    "TelescopeNormal", "TelescopeBorder",

  }
  
  for _, hl in ipairs(highlights) do
    vim.cmd(string.format("highlight %s guibg=NONE ctermbg=NONE", hl))
  end
  
  -- Désactiver cursorline
  vim.opt.cursorline = false
  vim.opt.cursorcolumn = false
  
  vim.notify("🧹 Transparence totale activée - Plus aucun fond coloré!", vim.log.levels.INFO)
end, { desc = "Force complete transparency" })

-- Basculer cursorline on/off rapidement
map("n", "<leader>uc", function()
  vim.opt.cursorline = not vim.opt.cursorline:get()
  local status = vim.opt.cursorline:get() and "activée" or "désactivée"
  vim.notify("Ligne courante " .. status, vim.log.levels.INFO)
end, { desc = "Toggle cursor line" })

-- Changer le style One Dark
map("n", "<leader>us", function()
  local styles = { "dark", "darker", "cool", "deep", "warm", "warmer" }
  local current_style = require("onedark").get_style()
  local current_index = 1
  
  for i, style in ipairs(styles) do
    if style == current_style then
      current_index = i
      break
    end
  end
  
  local next_index = (current_index % #styles) + 1
  local new_style = styles[next_index]
  
  require("onedark").setup({ style = new_style, transparent = true })
  require("onedark").load()
  
  vim.notify("🎨 Style One Dark: " .. new_style, vim.log.levels.INFO)
end, { desc = "Change One Dark style" })

-- Raccourcis terminal personnalisés
-- Terminal flottant avec <leader>tt (plus facile à retenir)
map("n", "<leader>tt", function()
  LazyVim.terminal()
end, { desc = "Terminal (float)" })

-- Terminal horizontal avec <leader>th
map("n", "<leader>th", function()
  LazyVim.terminal(nil, { position = "horizontal" })
end, { desc = "Terminal (horizontal)" })

-- Terminal vertical avec <leader>tv  
map("n", "<leader>tv", function()
  LazyVim.terminal(nil, { position = "vertical" })
end, { desc = "Terminal (vertical)" })

-- Diagnostic rapide des plugins
map("n", "<leader>ld", "<cmd>LazyDiagnostics<cr>", { desc = "Lazy Diagnostics" })

-- Forcer le chargement de tous les plugins
map("n", "<leader>lL", function()
  require("lazy").load({ plugins = require("lazy.core.config").spec.plugins })
  vim.notify("🔄 Tous les plugins forcés au chargement!", vim.log.levels.INFO)
end, { desc = "Load all plugins" })

-- Corriger les couleurs Supermaven
map("n", "<leader>uS", function()
  -- Appliquer les couleurs grises pour les suggestions
  vim.api.nvim_set_hl(0, "SupermavenSuggestion", {
    fg = "#5c6370",    -- Gris One Dark
    italic = true,
    bg = "NONE",
  })
  
  vim.api.nvim_set_hl(0, "SupermavenInlineSuggestion", {
    fg = "#6c7682",    -- Gris plus clair
    italic = true,
    bg = "NONE",
  })
  
  vim.api.nvim_set_hl(0, "CmpItemKindSupermaven", {
    fg = "#61afef",    -- Bleu pour l'icône
    bg = "NONE",
  })
  
  vim.notify("🎨 Couleurs Supermaven corrigées (grisées)", vim.log.levels.INFO)
end, { desc = "Fix Supermaven colors" })


