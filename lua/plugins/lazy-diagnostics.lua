-- Diagnostics et commandes utiles pour Lazy.nvim
return {
  {
    "folke/lazy.nvim",
    keys = {
      { "<leader>l", "", desc = "+lazy" },
      { "<leader>ll", "<cmd>Lazy<cr>", desc = "Lazy" },
      { "<leader>ls", "<cmd>Lazy status<cr>", desc = "Lazy Status" },
      { "<leader>lp", "<cmd>Lazy profile<cr>", desc = "Lazy Profile" },
      { "<leader>lu", "<cmd>Lazy update<cr>", desc = "Lazy Update" },
      { "<leader>lc", "<cmd>Lazy check<cr>", desc = "Lazy Check" },
      { "<leader>ld", "<cmd>Lazy debug<cr>", desc = "Lazy Debug" },
    },
    config = function()
      -- Commande pour voir les plugins qui ne chargent pas
      vim.api.nvim_create_user_command("LazyDiagnostics", function()
        local lazy = require("lazy")
        local config = require("lazy.core.config")
        
        print("=== DIAGNOSTIC LAZY.NVIM ===")
        print(string.format("Plugins installés: %d", #config.plugins))
        
        local loaded = 0
        local not_loaded = {}
        local errors = {}
        
        for name, plugin in pairs(config.plugins) do
          if plugin._.loaded then
            loaded = loaded + 1
          else
            table.insert(not_loaded, {
              name = name,
              reason = plugin.lazy and "lazy" or "not triggered",
              cond = plugin.cond,
              event = plugin.event,
              cmd = plugin.cmd,
              keys = plugin.keys,
              ft = plugin.ft,
            })
          end
          
          if plugin._.errors and #plugin._.errors > 0 then
            errors[name] = plugin._.errors
          end
        end
        
        print(string.format("Plugins chargés: %d/%d", loaded, #config.plugins))
        
        if #not_loaded > 0 then
          print("\n=== PLUGINS NON CHARGÉS (NORMAL) ===")
          for _, plugin in ipairs(not_loaded) do
            local triggers = {}
            if plugin.event then
              table.insert(triggers, "event: " .. vim.inspect(plugin.event))
            end
            if plugin.cmd then
              table.insert(triggers, "cmd: " .. vim.inspect(plugin.cmd))
            end
            if plugin.keys then
              table.insert(triggers, "keys: mappings")
            end
            if plugin.ft then
              table.insert(triggers, "ft: " .. vim.inspect(plugin.ft))
            end
            
            local trigger_str = #triggers > 0 and (" → " .. table.concat(triggers, ", ")) or ""
            print(string.format("  • %s (%s)%s", plugin.name, plugin.reason, trigger_str))
          end
        end
        
        if next(errors) then
          print("\n=== ERREURS ===")
          for name, errs in pairs(errors) do
            print(string.format("❌ %s:", name))
            for _, err in ipairs(errs) do
              print(string.format("  %s", err))
            end
          end
        else
          print("\n✅ Aucune erreur détectée!")
        end
        
        print("\n=== CONSEILS ===")
        print("• Les plugins 'lazy' se chargent quand vous les utilisez")
        print("• Utilisez :Lazy profile pour voir les temps de chargement")
        print("• Utilisez :Lazy health pour vérifier les problèmes")
      end, { desc = "Diagnostic complet des plugins Lazy" })
      
      -- Commande pour forcer le chargement d'un plugin
      vim.api.nvim_create_user_command("LazyLoad", function(opts)
        local plugin_name = opts.args
        if plugin_name == "" then
          print("Usage: :LazyLoad <plugin_name>")
          return
        end
        
        local lazy = require("lazy")
        lazy.load({ plugins = { plugin_name } })
        print(string.format("✅ Plugin '%s' chargé!", plugin_name))
      end, { 
        nargs = 1,
        complete = function()
          local config = require("lazy.core.config")
          local plugins = {}
          for name, plugin in pairs(config.plugins) do
            if not plugin._.loaded then
              table.insert(plugins, name)
            end
          end
          return plugins
        end,
        desc = "Forcer le chargement d'un plugin" 
      })
      
      -- Auto-affichage des stats au démarrage
      vim.defer_fn(function()
        local config = require("lazy.core.config")
        local loaded = 0
        local total = #config.plugins
        
        for _, plugin in pairs(config.plugins) do
          if plugin._.loaded then
            loaded = loaded + 1
          end
        end
        
        vim.notify(
          string.format("🚀 Lazy: %d/%d plugins chargés", loaded, total),
          vim.log.levels.INFO,
          { title = "LazyVim", timeout = 3000 }
        )
      end, 2000)
    end,
  },
}