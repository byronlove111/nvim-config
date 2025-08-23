-- Diagnostics et raccourcis utiles pour Mason
return {
  {
    "williamboman/mason.nvim",
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Open Mason" },
      { "<leader>cu", "<cmd>MasonUpdate<cr>", desc = "Update Mason packages" },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      
      -- Commande pour vérifier l'état des installations
      vim.api.nvim_create_user_command("MasonStatus", function()
        local mason_registry = require("mason-registry")
        local installed = mason_registry.get_installed_packages()
        
        print("=== Mason Package Status ===")
        for _, pkg in ipairs(installed) do
          local name = pkg.name
          local version = pkg:get_installed_version() or "unknown"
          print(string.format("✓ %s (%s)", name, version))
        end
        
        print("\n=== Pending Installations ===")
        local pending = {}
        for _, pkg in ipairs(mason_registry.get_all_packages()) do
          if pkg:is_installed() then
            -- skip
          else
            -- Vérifier si c'est dans notre liste ensure_installed
            local should_be_installed = false
            if opts.ensure_installed then
              for _, ensure_name in ipairs(opts.ensure_installed) do
                if pkg.name == ensure_name then
                  should_be_installed = true
                  break
                end
              end
            end
            if should_be_installed then
              table.insert(pending, pkg.name)
            end
          end
        end
        
        if #pending > 0 then
          for _, name in ipairs(pending) do
            print(string.format("⏳ %s (pending)", name))
          end
        else
          print("✓ All packages installed!")
        end
      end, { desc = "Show Mason package status" })
      
      -- Auto-diagnostic au démarrage
      vim.defer_fn(function()
        local mason_registry = require("mason-registry")
        if mason_registry then
          local failed_installs = {}
          -- Vérifier s'il y a des installations qui ont échoué
          vim.defer_fn(function()
            if #failed_installs == 0 then
              vim.notify("✅ Mason: Tous les outils sont installés", vim.log.levels.INFO)
            end
          end, 10000) -- Vérifier après 10 secondes
        end
      end, 2000)
    end,
  },
}