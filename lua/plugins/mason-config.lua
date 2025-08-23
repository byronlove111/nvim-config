-- Configuration optimisée de Mason pour éviter les erreurs de timing
return {
  -- Configuration de Mason (gestionnaire d'outils LSP/formatters/linters)
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        -- LSP servers essentiels
        "lua-language-server",
        "typescript-language-server",
        "pyright",
        
        -- Formatters essentiels (installation prioritaire)
        "stylua",
        "prettier",
        "black",
        "isort",
        "shfmt",
        
        -- Linters
        "eslint_d",
        "flake8",
        "shellcheck",
        "luacheck",
        "golangci-lint",
        "ktlint",
        "tflint",
        "yamllint",
        "jsonlint",
        "hadolint",
      },
      -- Configuration UI
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      -- Options de performance
      max_concurrent_installers = 3,
      install_root_dir = vim.fn.stdpath("data") .. "/mason",
    },
  },

  -- Installation différée des outils Go pour éviter les erreurs de timing
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = "User LazyVimStarted", -- Attendre que LazyVim soit complètement chargé
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- Outils Go (installation différée)
          "gofumpt",
          "goimports",
          "gopls",
          
          -- Autres outils moins prioritaires
          "clang-format",
          "rustfmt",
          "rust-analyzer",
        },
        auto_update = false,
        run_on_start = true,
        start_delay = 5000, -- 5 secondes de délai
        debounce_hours = 24, -- Une fois par jour maximum
      })
      
      -- Message informatif
      vim.defer_fn(function()
        vim.notify("🔧 Installation des outils Mason en cours...", vim.log.levels.INFO, {
          title = "Mason",
          timeout = 3000,
        })
      end, 1000)
    end,
  },
}