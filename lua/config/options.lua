-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Configuration du formatage
vim.g.autoformat = true -- Activer le formatage automatique globalement

-- Configuration de la transparence
vim.opt.termguicolors = true -- Support des couleurs 24-bit
vim.opt.winblend = 0 -- Transparence des fenêtres flottantes (0-100)
vim.opt.pumblend = 0 -- Transparence du menu popup (0-100)

-- Désactiver les éléments UI colorés
vim.opt.cursorline = false -- Pas de highlight de ligne courante
vim.opt.cursorcolumn = false -- Pas de highlight de colonne courante
