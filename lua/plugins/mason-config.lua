return {
  -- Mason: gestionnaire d'outils LSP/formatters/linters
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Open Mason" },
    },
    config = function()
      require("mason").setup({
        ensure_installed = {
        "lua-language-server",
        "typescript-language-server",
        "pyright",
        "clangd",
        "clang-format",
          "stylua",
          "prettier",
          "black",
          "isort",
          "shfmt",
          "eslint_d",
          "flake8",
          "shellcheck",
        },
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
        max_concurrent_installers = 3,
      })
    end,
  },

  -- mason-lspconfig: pont entre mason et lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
    dependencies = { "williamboman/mason.nvim" },
  },

  -- Installation d'outils supplémentaires en différé
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = "VeryLazy",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "gopls",
          "gofumpt",
          "goimports",
          "clang-format",
          "rust-analyzer",
        },
        auto_update = false,
        run_on_start = true,
        start_delay = 5000,
        debounce_hours = 24,
      })
    end,
  },
}
