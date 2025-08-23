-- Configuration pour debugger les problèmes de chargement
return {
  -- Améliorer la configuration de Lazy pour plus de feedback
  {
    "folke/lazy.nvim",
    opts = {
      -- Configuration pour plus de visibilité
      ui = {
        border = "rounded",
        title = "💤 Lazy.nvim",
        size = { width = 0.8, height = 0.8 },
      },
      
      -- Notification des installations
      install = {
        missing = true,
        colorscheme = { "onedark" },
      },
      
      -- Vérification automatique
      checker = {
        enabled = true,
        notify = false, -- Pas de spam de notifications
        frequency = 3600, -- Vérifier toutes les heures
      },
      
      -- Configuration de performance
      performance = {
        cache = {
          enabled = true,
          path = vim.fn.stdpath("cache") .. "/lazy/cache",
          disable_events = { "UIEnter", "BufReadPre" },
        },
        reset_packpath = true,
        rtp = {
          reset = true,
          disabled_plugins = {
            "gzip",
            "matchit",
            "matchparen", 
            "netrwPlugin",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zipPlugin",
          },
        },
      },
      
      -- Debug pour voir ce qui se passe
      debug = false, -- Mettre à true si vous voulez plus de logs
    },
  },
  
  -- Commande pour vérifier la santé complète
  {
    "folke/lazy.nvim",
    config = function()
      -- Commande de santé complète
      vim.api.nvim_create_user_command("LazyHealthCheck", function()
        print("🔍 VÉRIFICATION SANTÉ LAZYVIM...")
        
        -- Vérifier Neovim version
        local version = vim.version()
        if version.major == 0 and version.minor >= 9 then
          print("✅ Neovim version: " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch)
        else
          print("❌ Neovim version trop ancienne!")
        end
        
        -- Vérifier Git
        if vim.fn.executable("git") == 1 then
          print("✅ Git disponible")
        else
          print("❌ Git non trouvé!")
        end
        
        -- Vérifier les dépendances
        local deps = { "curl", "wget", "unzip", "tar", "gzip" }
        for _, dep in ipairs(deps) do
          if vim.fn.executable(dep) == 1 then
            print("✅ " .. dep .. " disponible")
          else
            print("⚠️  " .. dep .. " non trouvé (optionnel)")
          end
        end
        
        -- Statistiques des plugins
        vim.cmd("Lazy health")
      end, { desc = "Vérification santé complète" })
      
      -- Auto-diagnostic silencieux au démarrage
      vim.defer_fn(function()
        local config = require("lazy.core.config")
        local stats = require("lazy.stats")
        
        -- Vérifier s'il y a des erreurs
        local errors = {}
        for name, plugin in pairs(config.plugins) do
          if plugin._.errors and #plugin._.errors > 0 then
            errors[name] = plugin._.errors
          end
        end
        
        if next(errors) then
          vim.notify(
            "⚠️ Certains plugins ont des erreurs. Utilisez :LazyDiagnostics",
            vim.log.levels.WARN
          )
        end
        
        -- Stats de performance
        local startuptime = stats.startuptime()
        if startuptime > 50 then
          vim.notify(
            string.format("⚡ Démarrage: %.1fms (bon)", startuptime),
            vim.log.levels.INFO
          )
        else
          vim.notify(
            string.format("🚀 Démarrage: %.1fms (excellent!)", startuptime),
            vim.log.levels.INFO
          )
        end
      end, 3000)
    end,
  },
}